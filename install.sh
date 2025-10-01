#!/bin/bash

echo "=== Установка системы мониторинга процесса ==="

# Копируем скрипт в системную директорию
echo "1. Копируем скрипт..."
sudo cp process_monitor.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/process_monitor.sh

# Копируем systemd файлы
echo "2. Устанавливаем systemd юниты..."
sudo cp process-monitor.service /etc/systemd/system/
sudo cp process-monitor.timer /etc/systemd/system/

# Перезагружаем systemd
echo "3. Перезагружаем systemd..."
sudo systemctl daemon-reload

# Создаём лог-файл
echo "4. Создаём лог-файл..."
sudo touch /var/log/monitoring.log
sudo chmod 644 /var/log/monitoring.log

# Запускаем таймер
echo "5. Запускаем таймер..."
sudo systemctl enable process-monitor.timer
sudo systemctl start process-monitor.timer

echo ""
echo "✅ Установка завершена!"
echo ""
echo "Проверить статус: sudo systemctl status process-monitor.timer"
echo "Посмотреть логи:  sudo tail -f /var/log/monitoring.log"

