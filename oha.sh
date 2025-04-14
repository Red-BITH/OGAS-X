#!/bin/bash

echo "[*] Retro95 setup başlıyor..."

# Gereken paketleri yükle
sudo xbps-install -Sy icewm rox-filer feh lxappearance xorg xinit menu

# X başlatıcı ayarı
echo "exec icewm-session" > ~/.xinitrc

# Arka plan resmi
mkdir -p ~/Pictures/wallpapers
curl -L -o ~/Pictures/wallpapers/retro95.jpg https://i.imgur.com/wjWkyoL.jpg

# Başlangıçta wallpaper ayarı için autostart dosyası
mkdir -p ~/.icewm
cat <<EOF > ~/.icewm/startup
#!/bin/sh
feh --bg-scale ~/Pictures/wallpapers/retro95.jpg &
rox --pinboard=ROX-Filer &
EOF
chmod +x ~/.icewm/startup

# Menü güncelleme
sudo update-menus
cp /etc/X11/icewm/system.menu ~/.icewm/menu

# Tema önerisi
cat <<EOF > ~/.icewm/preferences
Theme="win95"
EOF

# Win95 teması indir
mkdir -p ~/.icewm/themes
cd ~/.icewm/themes
git clone https://github.com/bbidulock/icewm-extra-themes.git
mv icewm-extra-themes/win95 ~/.icewm/themes/
rm -rf icewm-extra-themes

echo "[✔] Retro95 hazır. Sistemi yeniden başlat, ardından 'startx' de."

