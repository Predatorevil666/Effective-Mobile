#!/bin/bash

# === НАСТРОЙКИ ===
PROCESS_NAME="test"
MONITORING_URL="https://test.com/monitoring/test/api"
LOG_FILE="/var/log/monitoring.log"
STATE_FILE="/var/run/process_monitor.state"

# === ФУНКЦИЯ: Записать сообщение в лог ===
log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# === ОСНОВНАЯ ЛОГИКА ===

# Найти PID процесса (если процесс запущен)
current_pid=$(pgrep -x "$PROCESS_NAME" | head -n 1)

# Прочитать старый PID из файла (если есть)
if [ -f "$STATE_FILE" ]; then
    previous_pid=$(cat "$STATE_FILE")
else
    previous_pid=""
fi

# Если процесс НЕ запущен - ничего не делаем
if [ -z "$current_pid" ]; then
    # Удалить файл состояния, если процесс остановлен
    rm -f "$STATE_FILE"
    exit 0
fi

# === ПРОЦЕСС ЗАПУЩЕН ===

# Проверить, был ли перезапуск (PID изменился)
if [ -n "$previous_pid" ] && [ "$current_pid" != "$previous_pid" ]; then
    log_message "ПЕРЕЗАПУСК: Процесс '$PROCESS_NAME' перезапущен (старый PID: $previous_pid, новый PID: $current_pid)"
fi

# Сохранить текущий PID
echo "$current_pid" > "$STATE_FILE"

# Отправить HTTPS-запрос на сервер мониторинга
if ! curl -s -f -m 10 "$MONITORING_URL" > /dev/null 2>&1; then
    log_message "ОШИБКА: Сервер мониторинга недоступен ($MONITORING_URL)"
fi

exit 0

