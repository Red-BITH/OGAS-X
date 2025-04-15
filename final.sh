#!/bin/bash

# Root yetkisi kontrolü
if [ "$EUID" -ne 0 ]; then
  echo "Lütfen scripti sudo ile çalıştır."
  exit
fi

echo "[*] Tüm grafik ortamları temizleniyor..."
xbps-remove -R -y xorg* icewm* pcmanfm* feh rox* fluxbox* openbox* lxde* xfce4* kde* gnome* gvfs* udisks2* conky*

echo "[*] Gerekli paketler kuruluyor..."
xbps-install -Sy xorg-minimal xinit icewm pcmanfm xfe dejavu-fonts-ttf

echo "[*] XFE varsayılan dosya yöneticisi olarak ayarlanıyor..."
mkdir -p /home/$USER/.local/share/applications

cat > /home/$USER/.local/share/applications/xfe.desktop <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Xfe
Exec=xfe
Icon=system-file-manager
Categories=Utility;FileManager;
Terminal=false
EOF

cat > /home/$USER/.local/share/applications/mimeapps.list <<EOF
[Default Applications]
inode/directory=xfe.desktop
EOF

echo "[*] .xinitrc hazırlanıyor..."
cat > /home/$USER/.xinitrc <<EOF
#!/bin/sh
xsetroot -solid "#202020" &
pcmanfm --desktop --set-wallpaper /home/$USER/Pictures/wallpapers/retro95.jpg &
exec icewm
EOF

chmod +x /home/$USER/.xinitrc

echo "[*] Masaüstü klasörü oluşturuluyor..."
mkdir -p /home/$USER/Pictures/wallpapers

echo "[*] Kurulum tamamlandı! Şimdi X başlatmak için terminalden 'startx' yaz."
