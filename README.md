# Личная CRM — лендинг

Одна страница: рассказывает о приложении и ведёт в него кнопкой «Открыть приложение».

## Как посмотреть у себя

Нужны Node.js 22.12 или новее и pnpm.

1. Установите зависимости (один раз): `pnpm install`
2. Запустите: `pnpm dev`
3. Откройте в браузере http://localhost:4321 — правки видны сразу после сохранения файла

Проверить готовую версию, как её увидят посетители: `pnpm build`, затем `pnpm preview`.
Готовый сайт лежит в папке `dist/`. Остановить `pnpm preview`: `pnpm astro preview stop`.

## Где что лежит

- Тексты страницы — `src/content/landing.ts`
- Цвета, шрифты, размеры текста и отступы — `src/styles/tokens.css`
- Блоки страницы — `src/components/`, собираются в `src/pages/index.astro`
- Макет — `design/`

## Как выкатывается

Каждый push в ветку `main` сам выкладывает новую версию на https://example-crm.site:

1. GitHub Actions собирает сайт (`pnpm build`)
2. Заливает папку `dist/` на сервер в `/var/www/example-crm.site` через `rsync --delete`
3. Проверяет, что главная отвечает 200 и это именно новая сборка

Ход выкатки — вкладка Actions на GitHub, файл — `.github/workflows/deploy.yml`.
Перезапустить выкатку без нового коммита: Actions → Deploy → Run workflow.

Ключ деплоя и адрес сервера лежат в секретах репозитория (`DEPLOY_SSH_KEY`, `DEPLOY_KNOWN_HOSTS`, `DEPLOY_HOST`, `DEPLOY_USER`).
На сервере ключ ограничен: он может только залить файлы в папку лендинга.

## Адрес приложения

Кнопки ведут на https://app.example-crm.site.
Чтобы при сборке подставить другой адрес, задайте `PUBLIC_APP_URL` (см. `.env.example`).
