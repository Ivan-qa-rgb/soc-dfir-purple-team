.PHONY: up down ps logs validate clean config

up:
	docker compose up -d

down:
	docker compose down

ps:
	docker compose ps

logs:
	docker compose logs -f

validate:
	docker compose exec kibana curl -fsS http://localhost:5601/api/status

config:
	docker compose config

clean:
	docker compose down -v
	rm -rf logs/*

Что делает каждый target
up — поднимает стенд.

down — останавливает контейнеры.

ps — показывает состояние контейнеров.

logs — выводит логи.

validate — проверяет, что Kibana отвечает.

config — показывает итоговую конфигурацию Compose.

clean — удаляет контейнеры, volume и логи.
