#!/usr/bin/env bash
# Installs the landing security headers on the server. Needs root: sudo bash apply-landing-security.sh
# Adds one include line to the landing server block of crm.conf, checks the config, reloads nginx.
# If the check fails, crm.conf is restored and nginx is left untouched.
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)/landing-security.conf"
DST=/etc/nginx/snippets/crm-landing-security.conf
CONF=/etc/nginx/sites-available/crm.conf
ANCHOR='root /var/www/example-crm.site;'

[ "$(id -u)" = 0 ] || { echo "Run with sudo"; exit 1; }
[ -f "$SRC" ] || { echo "Missing $SRC"; exit 1; }

# The anchor line exists only in the landing block, so the include cannot land in another site
[ "$(grep -cF "$ANCHOR" "$CONF")" = 1 ] || { echo "Cannot find the landing block in $CONF, nothing changed"; exit 1; }

BACKUP=""
if ! grep -qF "$DST" "$CONF"; then
  BACKUP="$CONF.bak-$(date +%Y%m%d-%H%M%S)"
  cp -p "$CONF" "$BACKUP"
fi

install -m 644 -o root -g root "$SRC" "$DST"

if [ -n "$BACKUP" ]; then
  sed -i "/root \/var\/www\/example-crm.site;/a\\    include $DST;  # added: security headers" "$CONF"
fi

if nginx -t; then
  systemctl reload nginx
  echo "Done: nginx reloaded. Backup: ${BACKUP:-none (already applied)}"
else
  if [ -n "$BACKUP" ]; then cp -p "$BACKUP" "$CONF"; fi
  echo "nginx check failed: crm.conf restored, nginx not reloaded"
  exit 1
fi
