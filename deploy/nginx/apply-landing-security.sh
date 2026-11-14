#!/usr/bin/env bash
# Installs the landing security headers on the server. Needs root: sudo bash apply-landing-security.sh
# Makes two small edits in crm.conf, checks the config, reloads nginx. Safe to run again.
#   1. landing https block: include of the security headers snippet
#   2. shared port 80 redirect block: server_tokens off (hides the nginx version on the redirect)
# If the check fails, crm.conf is restored and nginx is left untouched.
set -euo pipefail

SRC="$(cd "$(dirname "$0")" && pwd)/landing-security.conf"
DST=/etc/nginx/snippets/crm-landing-security.conf
CONF=/etc/nginx/sites-available/crm.conf

LANDING_ANCHOR='root /var/www/example-crm.site;'
REDIRECT_ANCHOR='server_name example-crm.site app.example-crm.site;'
REDIRECT_MARK='# added: hide the nginx version on the redirect'

[ "$(id -u)" = 0 ] || { echo "Run with sudo"; exit 1; }
[ -f "$SRC" ] || { echo "Missing $SRC"; exit 1; }

# Each anchor line exists exactly once, in the right block, so nothing lands in another site
for anchor in "$LANDING_ANCHOR" "$REDIRECT_ANCHOR"; do
  [ "$(grep -cF "$anchor" "$CONF")" = 1 ] || { echo "Cannot find '$anchor' once in $CONF, nothing changed"; exit 1; }
done

need_include=0; need_tokens=0
grep -qF "$DST" "$CONF" || need_include=1
grep -qF "$REDIRECT_MARK" "$CONF" || need_tokens=1

BACKUP=""
if [ "$need_include" = 1 ] || [ "$need_tokens" = 1 ]; then
  BACKUP="$CONF.bak-$(date +%Y%m%d-%H%M%S)"
  cp -p "$CONF" "$BACKUP"
fi

install -m 644 -o root -g root "$SRC" "$DST"

if [ "$need_include" = 1 ]; then
  sed -i "/root \/var\/www\/example-crm.site;/a\\    include $DST;  # added: security headers" "$CONF"
fi
if [ "$need_tokens" = 1 ]; then
  sed -i "/server_name example-crm.site app.example-crm.site;/a\\    server_tokens off;  $REDIRECT_MARK" "$CONF"
fi

if nginx -t; then
  systemctl reload nginx
  echo "Done: nginx reloaded. Backup: ${BACKUP:-none (nothing to change)}"
else
  if [ -n "$BACKUP" ]; then cp -p "$BACKUP" "$CONF"; fi
  echo "nginx check failed: crm.conf restored, nginx not reloaded"
  exit 1
fi
