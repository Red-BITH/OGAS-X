#!/bin/bash

# Void Linux Retro Fluxbox Desktop Kurulumu

echo "[+] Gerekli paketler yükleniyor..."

sudo xbps-install -Sy \
  xorg \
  xinit \
  xterm \
  fluxbox \
  rofi \
  tint2 \
  conky \
  feh \
  neofetch \
  fonts-ttf-dejavu \
  cmatrix \
  xsetroot

# .xinitrc oluşturuluyor
echo 'exec startfluxbox' > ~/.xinitrc

# Fluxbox config
mkdir -p ~/.fluxbox
cp -r /etc/X11/fluxbox/init ~/.fluxbox/
cp -r /etc/X11/fluxbox/keys ~/.fluxbox/
cp -r /etc/X11/fluxbox/menu ~/.fluxbox/

# Tint2 varsayılan ayarı
mkdir -p ~/.config/tint2
cp /etc/xdg/tint2/tint2rc ~/.config/tint2/

# Conky ayarı
mkdir -p ~/.config/conky
cat <<EOF > ~/.config/conky/conky.conf
conky.config = {
    alignment = 'top_right',
    background = true,
    update_interval = 2,
    double_buffer = true,
    own_window = true,
    own_window_type = 'desktop',
    own_window_argb_visual = true,
    minimum_width = 200,
    minimum_height = 5,
    use_xft = true,
    font = 'DejaVu Sans Mono:size=9',
};
conky.text = [[
\$time
CPU: \$cpu%
RAM: \$mem / \$memmax
Uptime: \$uptime
]];
EOF

# Arkaplan (siyaha boyar)
xsetroot -solid "#000000"

# .bashrc'ye neofetch ekle
if ! grep -q "neofetch" ~/.bashrc; then
  echo "neofetch" >> ~/.bashrc
fi

echo "[✓] Kurulum tamamlandı. Reboot at, sonra login ol ve 'startx' yaz."
