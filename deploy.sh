#!/usr/bin/env bash
# ==============================================================================
# Poliklinika Rahbar Paneli - Serverga Joylashtirish Skripti (Ubuntu 22.04 / 24.04)
# Domen: poliklinika.tajriba24.uz
# ==============================================================================

set -e

DOMAIN="poliklinika.tajriba24.uz"
WEB_ROOT="/var/www/poliklinika"
NGINX_CONF="/etc/nginx/sites-available/$DOMAIN"
NGINX_ENABLED="/etc/nginx/sites-enabled/$DOMAIN"

echo "=========================================================="
echo ">>> Poliklinika Rahbar Paneli o'rnatish boshlandi..."
echo "=========================================================="

# 1. Tizim paketlarini yangilash va kerakli dasturlarni o'rnatish
echo ">>> 1. Nginx va Certbot o'rnatilmoqda..."
sudo apt-get update -y
sudo apt-get install -y nginx certbot python3-certbot-nginx curl git

# 2. Veb-katalog yaratish va fayllarni nusxalash
echo ">>> 2. Veb katalog tayyorlanmoqda ($WEB_ROOT)..."
sudo mkdir -p "$WEB_ROOT"
sudo cp index.html "$WEB_ROOT/"
sudo chown -R www-data:www-data "$WEB_ROOT"
sudo chmod -R 755 "$WEB_ROOT"

# 3. Nginx konfiguratsiyasini o'rnatish
echo ">>> 3. Nginx konfiguratsiyasi sozlanmoqda..."
if [ -f "poliklinika.tajriba24.uz.conf" ]; then
    sudo cp poliklinika.tajriba24.uz.conf "$NGINX_CONF"
else
    sudo tee "$NGINX_CONF" > /dev/null <<EOF
server {
    listen 80;
    listen [::]:80;
    server_name $DOMAIN;

    root $WEB_ROOT;
    index index.html;

    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_proxied any;
    gzip_types text/plain text/css text/xml application/json application/javascript image/svg+xml image/webp;

    add_header X-Content-Type-Options "nosniff" always;
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;

    location / {
        try_files \$uri \$uri/ /index.html;
    }

    location ~* \.(?:ico|css|js|gif|jpe?g|png|webp|svg)$ {
        expires 30d;
        add_header Cache-Control "public, max-age=2592000, immutable";
    }

    location /health {
        access_log off;
        return 200 "OK\n";
    }
}
EOF
fi

# 4. Saytni faollashtirish
sudo ln -sf "$NGINX_CONF" "$NGINX_ENABLED"
sudo nginx -t
sudo systemctl reload nginx

echo ">>> 4. Nginx muvaffaqiyatli qayta yuklandi!"

# 5. SSL sertifikati (Certbot / Let's Encrypt)
echo ">>> 5. SSL (HTTPS) sertifikatini olish..."
echo "DNS yozuvlari tarqalgandan so'ng quyidagi buyruqni ishga tushiring:"
echo "sudo certbot --nginx -d $DOMAIN --non-interactive --agree-tos --email admin@$DOMAIN --redirect"

echo "=========================================================="
echo ">>> O'rnatish muvaffaqiyatli yakunlandi!"
echo ">>> Sayt manzili: http://$DOMAIN"
echo "=========================================================="
