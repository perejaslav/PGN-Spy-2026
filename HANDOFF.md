# HANDOFF

## Где мы остановились

2026-10-18. Выпущен **v1.2.3**: https://github.com/perejaslav/PGN-Spy-2026/releases/tag/v1.2.3
Основная ветка — `master`. Рабочая ветка агента — `claude/serene-fermi-9thrdw`, вливается через PR.

Сейчас в работе — «дооформление»:
- переведены все сообщения окна анализа;
- обновлены README (ru/en), `BUILD-WINDOWS11.md`, release notes v1.2.3;
- workflow умеет перевыпускать существующую версию.

После мержа перезапустить релиз 1.2.3, чтобы zip и описание совпали с `master`.

## Проект в двух словах

- `PGN Spy/` — GUI на MFC (Windows). Запускает `pgn-extract.exe` и `uci-analyser.exe`, считает T1/T2/T3 и потери в сотых пешки.
- `uci-analyser/` — консольная программа. Гоняет UCI-движок по партиям, пишет XML. Собирается и под Linux (`make`).
- `.github/workflows/release.yml` — сборка на `windows-2022` для каждого PR и push в `master`. Ручной запуск с `version` публикует релиз.
- `scripts/package.ps1` — та же сборка и zip локально.

## Как выпустить новую версию

1. Поднять версию: `PGN Spy/app.manifest`, `PGN Spy/PGN Spy.rc` (4 места), `VERSION` в `uci-analyser/analyse.cpp`, README.
2. Написать `docs/releases/vX.Y.Z.ru.md` и `.en.md`.
3. Влить в `master`, запустить workflow «Build and release» с `version = X.Y.Z`.

`pgn-extract.exe` берётся из релиза v1.2.1. Если его удалят — workflow упадёт.

## Что сделано в v1.2.3

Исправлено 15 багов из обзора: зависание движка, T1 для неоценённых ходов, фильтр «после ухудшения», коды ошибок, stderr, FEN-экспорт, XML-экранирование, UTF-8, границы массивов, утечка, Linux-сборка, argv[0], версии, `.aps`.
Плюс прогресс по ходам, пояснения в результатах, автосборка и релизы, имя Setup-проекта в `.sln`.

## Что осталось

- Справка (кнопки «?») в окне результатов и часть сообщений там — только на английском.
- `Setup/Setup.vdproj` устарел (Stockfish 7/8, .NET 4.5). Либо удалить, либо заменить на zip/Inno Setup.
- `EscapeCmdArg` по сути ничего не делает (в путях Windows нет кавычек) — безвредно.
- Номера ходов в статистике для партий с FEN считаются от книги, а не от FEN.
- Идеи: тесты на `CStats`/`CPosition`, таймаут на партию в GUI, экспорт в CSV.
