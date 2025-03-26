#!/bin/bash

LOG_DOSYASI="$1"

if [ -z "$LOG_DOSYASI" ]; then
    echo "Kullanım: $0 /var/log/dosya.log"
    exit 1
fi

echo "Bayraktar16 LogWatcher v1 çalışıyor..."
echo "Hedef Log: $LOG_DOSYASI"
echo "-------------------------------"

echo "[!] Şüpheli IP Girişleri:"
grep -E 'Failed|Invalid|authentication error' "$LOG_DOSYASI" | awk '{print $1}' | sort | uniq -c | sort -nr | head -10

echo -e "\n[!] Kritik Hata Mesajları:"
grep -iE 'error|fail|denied|unauthorized' "$LOG_DOSYASI" | tail -n 10

echo -e "\n[!] Tarih Bazlı Giriş Özeti:"
grep -Eo '[A-Za-z]{3} [ 0-9]{2}' "$LOG_DOSYASI" | sort | uniq -c

echo -e "\nİşlem tamamlandı. BAYRAKTAR16 gözcünüzdür."
