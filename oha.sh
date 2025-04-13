#!/bin/bash

echo "💾 FluxRIG kuruluyor... hazır ol! 🔥"

# 1. Gereksiz her şeyi yok et
sudo xbps-remove -Ry openbox lxqt xfce4 kde5 lightdm slim lxdm gdm xdm picom tint2 rofi feh conky xterm -y
rm -rf ~/.config ~/.local ~/.cache ~/.xinitrc ~/.xsession ~/.xsession-errors ~/.fluxbox

# 2. Lazım olan paketleri kur
sudo xbps-install -Sy xorg xinit fluxbox xterm cmatrix cowsay lolcat neofetch terminus-font

# 3. Fontu aktif et
fc-cache -fv

# 4. .xinitrc yaz
cat > ~/.xinitrc <<EOF
xrdb -merge ~/.Xresources
setxkbmap -option ctrl:nocaps
exec startfluxbox
EOF

# 5. Fluxbox konfigleri
mkdir -p ~/.fluxbox/styles

# Tema: RetroDark
cat > ~/.fluxbox/styles/RetroDark <<EOF
background: flat
background.color: #000000
borderColor: #00ff00
textColor: #00ff00
menu.title.textColor: #00ff00
window.label.textColor: #00ff00
EOF

# Fluxbox ayarları
cat > ~/.fluxbox/init <<EOF
session.styleFile: ~/.fluxbox/styles/RetroDark
session.screen0.toolbar.tools: workspacename, prevworkspace, nextworkspace, iconbar, systemtray, clock
session.screen0.toolbar.height: 20
session.screen0.slit.autoHide: true
EOF

# Başlangıç uygulamaları
cat > ~/.fluxbox/startup <<EOF
#!/bin/sh
xsetroot -solid black &
xterm -bg black -fg green -fa 'Terminus' -fs 12 -e cmatrix &
exec fluxbox
EOF
chmod +x ~/.fluxbox/startup

# 6. Retro terminal mesajı
cat >> ~/.bashrc <<EOF

clear
cowsay -f turtle "WELCOME TO FLUXRIG" | lolcat
neofetch
EOF

echo "✅ Kurulum tamam. Sistemi kapat aç, ya da 'startx' yaz. 🚀"
