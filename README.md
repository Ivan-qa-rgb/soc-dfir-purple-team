# SOC / DFIR Purple Team 

Production-like лаборатория для практики SOC, IR и DFIR на Docker Compose с Suricata, Elasticsearch и Kibana.

## Что это

Это изолированный стенд для отработки detection engineering, incident response и повторяемых Purple Team-сценариев на Ubuntu.

## Зачем это нужно

Проект показывает:
- как проектировать изолированную security-лабораторию;
- как собирать и анализировать сетевые события;
- как работать с `eve.json` от Suricata;
- как строить повторяемый DFIR-процесс;
- как оформлять практику в виде портфолио.

## Стек

- Docker Compose.
- Elasticsearch 8.11.0.
- Kibana 8.11.0.
- Suricata 7.x.
- Контейнер Ubuntu-жертвы.

## Основные особенности

- Закреплённые версии образов вместо `latest`.
- Доступ к веб-интерфейсу только локально.
- Разделение внутренних и внешних сетей.
- Healthcheck для ключевых сервисов.
- Restart policy для долгоживущих контейнеров.
- Отсутствие plaintext-секретов в compose.
- Вывод Suricata в `eve.json` для последующего анализа.

## Быстрый старт

```bash
cp .env.example .env
mkdir -p logs rules
docker compose up -d
docker compose ps
```

## Проверка работоспособности

```bash
docker compose logs -f elasticsearch
docker compose logs -f kibana
docker compose exec kibana curl -fsS http://localhost:5601/api/status
```

## Вывод Suricata

Suricata пишет алерты и протокольные события в `eve.json`.  
Этот формат удобно использовать для индексации, фильтрации и корреляции через `jq`, Elasticsearch и Kibana [web:13][web:17][web:14].

Пример просмотра:

```bash
tail -f logs/eve.json | jq -c '.'
```

## Структура репозитория

```text
.
├── README.md
├── docker-compose.yml
├── suricata.yaml
├── .env.example
├── Makefile
├── rules/
│   └── local.rules
├── logs/
├── docs/
└── samples/
```

## Файлы

- `docker-compose.yml` — hardened-стенд.
- `suricata.yaml` — конфигурация JSON-вывода Suricata.
- `rules/local.rules` — кастомные правила детекта.
- `.env.example` — шаблон переменных окружения.
- `Makefile` — быстрые команды для управления стендом.

## Пример сценария

1. Генерируется тестовый трафик.
2. Срабатывает правило Suricata.
3. Событие попадает в `eve.json`.
4. Событие анализируется в Kibana.
5. Кейс документируется в `docs/purple_team_case.md`.

## Что показывает этот репозиторий

- проектирование лаборатории;
- detection engineering;
- DFIR-подход;
- дисциплину в развёртывании;
- умение оформлять результаты работы понятно и аккуратно.

## Важно

- Не хранить реальные секреты.
- Не загружать реальные инцидентные данные.
- Использовать только синтетические или обезличенные логи.
- Делать проект безопасным для публичного GitHub.

## Лицензия

MIT.
