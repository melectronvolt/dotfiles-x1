# Dotfiles X1 — SwayFX sur Fedora 44

Configuration SwayFX pour ThinkPad X1 Carbon, thème noir + accent jaune Catppuccin.

## Stack

- Compositeur : SwayFX (blur, rounded, shadows)
- Barre : Waybar
- Terminal : Foot
- Lanceur : Wofi
- Notifications : Mako
- Explorateur : Yazi
- Verrouillage : swaylock
- Capture : grim + slurp + wl-clipboard
- Agent polkit : lxpolkit
- Police : JetBrainsMono Nerd Font

## Palette

- Fond : `#1a1a1a`
- Accent : `#f9e2af` (Catppuccin Yellow)
- Rouge `#f38ba8` · Vert `#a6e3a1` · Cyan `#94e2d5`

## Installation sur une machine Fedora 44

### 1. Paquets

```bash
sudo dnf copr enable swayfx/swayfx
sudo dnf copr enable lihaohong/yazi
sudo dnf install \
    swayfx swaybg swayidle swaylock swaynag \
    waybar foot wofi mako \
    grim slurp brightnessctl playerctl \
    xdg-desktop-portal-wlr lxpolkit \
    NetworkManager-tui network-manager-applet libappindicator-gtk3 \
    pavucontrol sassc gtk-murrine-engine \
    yazi p7zip fzf zoxide blueman
```

### 2. Police JetBrains Mono Nerd Font

```bash
mkdir -p ~/.local/share/fonts/JetBrainsMono
curl -L -o /tmp/jbm.tar.xz \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xf /tmp/jbm.tar.xz -C ~/.local/share/fonts/JetBrainsMono
fc-cache -f
rm /tmp/jbm.tar.xz
```

### 3. Configs utilisateur (depuis la racine du repo)

```bash
mkdir -p ~/.config/sway ~/.config/waybar ~/.config/foot \
         ~/.config/wofi ~/.config/mako ~/.config/yazi ~/.local/bin

cp sway/*   ~/.config/sway/
cp waybar/* ~/.config/waybar/
cp foot/*   ~/.config/foot/
cp wofi/*   ~/.config/wofi/
cp mako/*   ~/.config/mako/
cp yazi/*   ~/.config/yazi/
cp bin/*    ~/.local/bin/
chmod +x ~/.local/bin/switch-accent
```

### 4. Auto-switch performance/powersave (laptop uniquement)

```bash
sudo cp system/auto-power-profile              /usr/local/bin/
sudo cp system/auto-power-profile.service      /etc/systemd/system/
sudo cp system/99-auto-power-profile.rules     /etc/udev/rules.d/
sudo chmod +x /usr/local/bin/auto-power-profile
sudo systemctl daemon-reload
sudo systemctl enable --now auto-power-profile.service
sudo udevadm control --reload-rules
```

### 5. LS_COLORS (dossiers jaunes dans bash)

Ajouter à `~/.bashrc` :

```bash
export LS_COLORS="${LS_COLORS}:di=01;33:ln=01;36:ow=01;33"
```

### 6. Login

Déconnexion de GNOME → GDM → engrenage en bas à droite → **Sway** → login.

## Switch d'accent rapide

```bash
switch-accent f9e2af   # yellow (défaut)
switch-accent b4befe   # lavender
switch-accent 74c7ec   # sapphire
switch-accent 89b4fa   # blue
switch-accent a6e3a1   # green
```

## Keybinds principaux

| Touches | Action |
|---|---|
| `Super+Return` | Terminal foot |
| `Super+d` | Lanceur wofi |
| `Super+Ctrl+e` | Explorateur yazi |
| `Super+Shift+q` | Fermer la fenêtre |
| `Super+Shift+c` | Recharger la config Sway |
| `Super+Shift+e` | Quitter Sway |
| `Super+1..9` | Workspace N |
| `Super+Shift+1..9` | Envoyer fenêtre vers workspace N |
| `Super+h/j/k/l` | Focus (vim-style) |
| `Super+Shift+h/j/k/l` | Déplacer la fenêtre |
| `Super+f` | Plein écran |
| `Super+r` | Resize mode |
| `Print` | Capture plein écran → presse-papier |
| `Shift+Print` | Capture zone → presse-papier |
| `Ctrl+Print` | Capture plein écran → ~/Pictures |
| `XF86Audio*` | Volume/mute (wpctl) |
| `XF86MonBrightness*` | Luminosité (brightnessctl) |

## Désinstallation

```bash
sudo dnf remove swayfx swaybg swayidle swaylock waybar foot wofi mako yazi
sudo dnf copr disable swayfx/swayfx
sudo dnf copr disable lihaohong/yazi
rm -rf ~/.config/{sway,waybar,foot,wofi,mako,yazi}
rm -rf ~/.local/share/fonts/JetBrainsMono
rm ~/.local/bin/switch-accent

sudo systemctl disable --now auto-power-profile.service
sudo rm /etc/systemd/system/auto-power-profile.service
sudo rm /etc/udev/rules.d/99-auto-power-profile.rules
sudo rm /usr/local/bin/auto-power-profile
```
