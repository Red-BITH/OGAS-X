#!/bin/bash

sudo xbps-install -Sy xorg xinit xterm fluxbox tint2 conky feh rofi neofetch cmatrix dejavu-fonts-ttf

echo "exec fluxbox" > ~/.xinitrc

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

if ! grep -q "neofetch" ~/.bashrc; then
  echo "neofetch" >> ~/.bashrc
fi

echo "[✓] Her şey tamam. Sistemi rebootla, sonra login olunca startx yaz."
