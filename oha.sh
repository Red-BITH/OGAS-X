#!/bin/bash

echo ">> Retro Fluxbox Setup başlıyor..."

# Paketleri kur
sudo xbps-install -Sy xorg xinit fluxbox feh tint2 conky rofi neofetch cmatrix toilet

# X başlangıcı ayarla
echo "exec fluxbox" > ~/.xinitrc

# Wallpaper klasörü oluştur
mkdir -p ~/Pictures/wallpapers
curl -L -o ~/Pictures/wallpapers/retro.jpg https://i.imgur.com/wjWkyoL.jpg

# Fluxbox startup dosyası
mkdir -p ~/.fluxbox
cat <<EOF > ~/.fluxbox/startup
#!/bin/sh
feh --bg-scale ~/Pictures/wallpapers/retro.jpg &
tint2 &
conky &
exec fluxbox
EOF
chmod +x ~/.fluxbox/startup

# Conky config
mkdir -p ~/.config/conky
cat <<EOF > ~/.config/conky/conky.conf
conky.config = {
    alignment = 'top_right',
    background = true,
    update_interval = 1,
    double_buffer = true,
    own_window = true,
    own_window_type = 'desktop',
    own_window_argb_visual = true,
    minimum_width = 200,
    minimum_height = 5,
    use_xft = true,
    font = 'DejaVu Sans Mono:size=9',
    gap_x = 20,
    gap_y = 50,
};
conky.text = [[
\\\${time %H:%M:%S}
CPU: \\\${cpu}%
RAM: \\\${mem} / \\\${memmax}
Uptime: \\\${uptime}
]];
EOF

# ASCII şov .bashrc içine
if ! grep -q "ascii_show" ~/.bashrc; then
cat <<'EOF' >> ~/.bashrc

ascii_show() {
  clear
  toilet -f mono12 -F metal "OGAS-X"
  neofetch
  cmatrix -b -C green -u 3
}
ascii_show
EOF
fi

echo ""
echo "🎉 Her şey hazır. Sistemi yeniden başlat, sonra terminalden startx yaz."
echo "🚀 Fluxbox açılacak, wallpaper + tint2 + conky + ASCII şov da yanında!"
