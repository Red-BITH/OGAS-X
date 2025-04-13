#!/bin/bash

echo "[+] Paket listesi güncelleniyor..."
sudo xbps-install -Suy

echo "[+] Gerekli paketler kuruluyor..."
sudo xbps-install -y openbox obconf tint2 rofi picom feh conky lxappearance alacritty xterm

echo "[+] .config dizinleri oluşturuluyor..."
mkdir -p ~/.config/openbox
mkdir -p ~/.config/tint2
mkdir -p ~/.config/picom
mkdir -p ~/Pictures/wallpapers

echo "[+] Openbox autostart ayarlanıyor..."
cat > ~/.config/openbox/autostart <<EOF
tint2 &
picom --config ~/.config/picom/picom.conf &
feh --bg-scale ~/Pictures/wallpapers/wall.jpg &
conky &
EOF

echo "[+] Basit picom.conf dosyası oluşturuluyor..."
cat > ~/.config/picom/picom.conf <<EOF
backend = "xrender";
vsync = true;
shadow = true;
fading = true;
fade-delta = 4;
EOF

echo "[+] Basit tint2 ayarı örneği ekleniyor..."
cat > ~/.config/tint2/tint2rc <<EOF
# Basit tint2 panel config (tema sonrası özelleştirilebilir)
panel_items = TSC
panel_size = 100% 30
panel_margin = 0 0
panel_padding = 6 6 6
EOF

echo "[+] Conky ayar dosyası hazırlanıyor..."
cat > ~/.conkyrc <<EOF
conky.config = {
    background = true,
    update_interval = 1,
    total_run_times = 0,
    double_buffer = true,
    own_window = true,
    own_window_type = 'desktop',
    alignment = 'top_right',
    minimum_width = 200,
    minimum_height = 200,
    gap_x = 20,
    gap_y = 60,
    use_xft = true,
    font = 'monospace:size=10',
};

conky.text = [[
CPU: \$cpu%
RAM: \$mem/\$memmax
Disk: \$fs_used/\$fs_size
Uptime: \$uptime
]];
EOF

echo "[+] Varsayılan wallpaper oluşturuluyor (yer tutucu)..."
curl -s https://picsum.photos/1920/1080 -o ~/Pictures/wallpapers/wall.jpg

echo "[✓] Kurulum tamamlandı!"
echo "➡️ Oturumu Openbox ile başlat ve tadını çıkar 😎"
