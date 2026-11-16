# 🏥 Poliklinika · Rahbar Nazorati Paneli

> **3 qavatli poliklinika rahbari uchun xodimlar davomati, harakati va bino monitoringi boshqaruv paneli.**  
> Loyiha jonli prototip asosida to'liq professional standartlarga moslashtirilgan bo'lib, har qanday zamonaviy serverga va bulutli muhitlarga bir zumda o'rnatishga tayyor.

---

## 🌐 Jonli Domen
- **Domen:** [poliklinika.tajriba24.uz](http://poliklinika.tajriba24.uz)
- **Server IP:** `95.130.227.92` (Eskiz VPS, Ubuntu 24.04)

---

## 🌟 Asosiy Imkoniyatlar

1. **📊 Umumiy Holat va KPI Tahlili:**
   - Kunning istalgan vaqt kesimidagi (masalan, 06:45, 11:30, 14:00, 18:15, 23:30) davomat ko'rsatkichlari.
   - Bo'limlar bo'yicha filtrlash (Terapiya, Diagnostika, Registratura, Hamshiralik).
   - Smena turlari (08:30–18:00, 08:00–14:00, 22:00–06:00).
   - CSV formatida to'liq hisobotlarni yuklab olish.

2. **🗺️ Interaktiv 3 Qavatli Bino Rejasi:**
   - 1-qavat: Qabul, registratura va diagnostika.
   - 2-qavat: Terapiya va ixtisoslashgan kabinetlar.
   - 3-qavat: Ma'muriyat va laboratoriyalar.
   - Xonalar, eshiklar, zinapoyalar va liftlar tarmog'i.

3. **📹 Xavfsizlik Kameralari va Qamrov Rejasi:**
   - Kameralar turlari: Yuz va yo'nalish (Face), Umumiy ko'rinish (Context), Yo'lak va zal (Corridor), Zinapoya va lift (Landing), Tashqi eshiklar (Conditional).
   - Kameralarning ko'rish burchaklari (FOV polygon) va qamrov doirasi.

4. **⏱️ Xodimlar Harakati va Marshrut Tarixi:**
   - Xodimning bino ichidagi kirish-chiqish nuqtalari (A, B, C punktlari).
   - Qaysi qavat va qaysi xonada qancha vaqt o'tkazganligi xaritada vizual chiziqlar bilan ko'rsatiladi.

5. **👥 Tashrifchilar va Bemorlar Oqimi:**
   - Tashrifchilar identifikatorlari, tashrif sanasi, harakat traektoriyasi va qidiruv tizimi.

6. **🔔 Tekshiruvlar va Nazorat Jurnali:**
   - Xodimlar davomatidagi qoidabuzarliklar, kechikishlar va xavfsizlik qaydlari.

---

## 🛠️ Texnologiyalar

- **Frontend:** Vanilla HTML5, Zamonaviy CSS3 (CSS Variables, Grid, Flexbox), ES6+ JavaScript.
- **Grafika:** Yuqori aniqlikdagi WebP xaritalar, vektorli SVG chizmalar va animatsiyalar.
- **Veb-server:** Nginx (Gzip siqish, xavfsizlik sarlavhalari, static cache).
- **Konteynerlashtirish:** Docker, Docker Compose.
- **CI/CD:** GitHub Actions orqali avtomatlashtirilgan joylashtirish.

---

## 🚀 Mahalliy Ishga Tushirish (Local Run)

Oddiy brauzerda yoki Node.js orqali:

```bash
# Node.js orqali ishga tushirish
npx serve -l 3000 .
# Brauzerda oching: http://localhost:3000
```

Yoki Python yordamida:
```bash
python -m http.server 3000
```

---

## 🐳 Docker Orqali Ishga Tushirish

```bash
# Docker konteynerini yig'ish va ishga tushirish
docker-compose up -d --build

# Holatini tekshirish
docker-compose ps
```

---

## 🖥️ Serverga Joylashtirish (Ubuntu 22.04 / 24.04 VPS)

Serverda (masalan, `95.130.227.92`):

```bash
# 1. Repozitoriyani yuklab olish
git clone https://github.com/Dariko-HR-Marketing/poliklinika.git /var/www/poliklinika-repo
cd /var/www/poliklinika-repo

# 2. Skriptga ruxsat berish va ishga tushirish
chmod +x deploy.sh
./deploy.sh
```

### Nginx qo'lda sozlash:
`/etc/nginx/sites-available/poliklinika.tajriba24.uz` fayliga:
```nginx
server {
    listen 80;
    server_name poliklinika.tajriba24.uz;

    root /var/www/poliklinika;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

Faollashtirish va qayta yuklash:
```bash
sudo ln -s /etc/nginx/sites-available/poliklinika.tajriba24.uz /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

### SSL (HTTPS) Sertifikatini olish (Certbot):
```bash
sudo certbot --nginx -d poliklinika.tajriba24.uz
```

---

## 📁 Loyiha Strukturasi

```
├── .github/
│   └── workflows/
│       └── deploy.yml           # GitHub Actions avtomatik deploy
├── .gitignore                   # Git istisno qoidalari
├── Dockerfile                   # Nginx asosidagi yengil Docker obrazi
├── docker-compose.yml           # Docker Compose konfiguratsiyasi
├── deploy.sh                    # Serverga bir tugma bilan o'rnatish skripti
├── index.html                   # To'liq integratsiyalangan boshqaruv paneli
├── nginx.conf                   # Docker ichidagi Nginx konfiguratsiyasi
├── poliklinika.tajriba24.uz.conf# Host Ubuntu Nginx konfiguratsiyasi
├── package.json                 # Loyiha boshqaruvi va skriptlar
└── README.md                    # To'liq qo'llanma
```

---

## 👤 Muallif va Ruxsatnoma

- **Tashkilot:** Dariko HR Marketing
- **GitHub:** [https://github.com/Dariko-HR-Marketing/poliklinika](https://github.com/Dariko-HR-Marketing/poliklinika)
- **Litsenziya:** MIT License
