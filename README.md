Система автоматического мониторинга процессов для Linux с использованием bash и systemd.



##  Описание

Скрипт автоматически мониторит процесс `test` в Linux.


## Быстрый старт

```bash
# Установка
chmod +x install.sh
./install.sh

# Проверка работы
sudo systemctl status process-monitor.timer
sudo tail -f /var/log/monitoring.log
```

## Структура

- `process_monitor.sh` - Основной скрипт мониторинга
- `process-monitor.service` - Systemd service unit
- `process-monitor.timer` - Systemd timer (запуск каждую минуту)
- `install.sh` - Скрипт автоматической установки



##  Основные команды

```bash
# Проверить статус
sudo systemctl status process-monitor.timer

# Остановить
sudo systemctl stop process-monitor.timer

# Запустить
sudo systemctl start process-monitor.timer

# Посмотреть логи
sudo tail -f /var/log/monitoring.log
```

**DevOps Engineer**: [Alexander Batogov](https://github.com/Predatorevil666)