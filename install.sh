set -e
sudo apt-add-repository universe -y
sudo apt-add-repository multiverse -y
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y \
	curl git unzip wget build-essential pkg-config autoconf bison clang \
	libssl-dev libreadline-dev zlib1g-dev libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev libjemalloc2 \
	libvips imagemagick libmagickwand-dev mupdf mupdf-tools \
	redis-tools sqlite3 libsqlite3-0 fzf ripgrep bat eza zoxide plocate btop apache2-utils fd-find \
    software-properties-common zsh gnome-tweaks gnome-shell-extension-manager virt-manager qemu-kvm mc \
    ca-certificates chromium vlc virt-manager usb-creator-gtk gparted gnome-sushi gnome-tweak-tool gnome-shell-extension-manager \
    gnome-shell-extension-manager pipx nodejs npm golang-go


# Docker 
sudo apt install -y docker.io
sudo usermod -aG docker ${USER}

# Github CLI tools
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg &&
	sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg &&
	echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
	sudo apt update &&
	sudo apt install gh -y


# Fastfetch
sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
sudo apt update -y
sudo apt install -y fastfetch

# Flatpak
sudo apt install -y flatpak
sudo apt install -y gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Flameshot is a nice step-up over the default Gnome screenshot tool
sudo apt install -y flameshot

# Oh My Posh
## Install Oh my Posh
sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
sudo chmod +x /usr/local/bin/oh-my-posh

## Download the Oh My Posh themes
cd ~
mkdir -p ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip -o ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.json
rm ~/.poshthemes/themes.zip
oh-my-posh init bash --config .poshthemes/montys.omp.json > .oh-my-post-init.sh
echo "source .oh-my-post-init.sh" >> .bashrc
cd -

# Downdload the fonts for Oh My Posh
cd ~
mkdir -p .fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
rm -rf ~/.fonts/JetBrainsMono
unzip ~/JetBrainsMono.zip -d ~/.fonts/JetBrainsMono
fc-cache -fv

# Add local fonts
mkdir -p ~/.local/share/fonts

cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
unzip CascadiaMono.zip -d CascadiaFont
cp CascadiaFont/*.ttf ~/.local/share/fonts
rm -rf CascadiaMono.zip CascadiaFont

sudo fc-cache -f -v

# ADD GLOBAL THEMES
cd /usr/share/themes
sudo rm -rf /usr/share/themes/Ant
sudo rm -rf /usr/share/themes/Nordic
sudo git clone https://github.com/EliverLara/Ant
sudo git clone https://github.com/EliverLara/Nordic

# ADD GLOBAL FONTS
sudo wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
sudo unzip -o JetBrainsMono.zip -d /usr/share/fonts/
sudo fc-cache -f -v


# Brave Browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update -y
sudo apt install -y brave-browser

# Spotify
# Stream music using https://spotify.com
curl -sS https://download.spotify.com/debian/pubkey_6224F9941A8AA6D1.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb [signed-by=/etc/apt/trusted.gpg.d/spotify.gpg] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update -y
sudo apt install -y spotify-client

# VirtualBox
sudo apt install -y virtualbox virtualbox-ext-pack
sudo usermod -aG vboxusers ${USER}

echo "Cloning UbuntuCode..."
rm -rf ~/.local/share/ubuntu-code
git clone https://github.com/weholt/ubuntu-code.git ~/.local/share/ubuntu-code >/dev/null
sudo cp ~/.local/share/ubuntu-code/backgrounds/*.* /usr/share/backgrounds/
sudo chmod -R a+r /usr/share/backgrounds

# Gnome Themes & Settings
cd ~
mkdir -p ~/.themes
mkdir -p ~/.icons

pipx install gnome-extensions-cli --system-site-packages

#gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
#gsettings set org.gnome.desktop.interface cursor-theme 'Yaru'
gsettings set org.gnome.desktop.interface gtk-theme "Yaru-blue-dark"
gsettings set org.gnome.desktop.interface icon-theme "Yaru-blue"
gsettings set org.gnome.desktop.background picture-uri "file://~/.local/share/ubuntu-code/themes/nord/background.png"
gsettings set org.gnome.desktop.background picture-options 'zoom'
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.desktop.interface gtk-theme "Nordic"
gsettings set org.gnome.desktop.wm.preferences theme "Nordic"
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.desktop.interface monospace-font-name 'CaskaydiaMono Nerd Font 10'
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.interface icon-theme candy-icons



# CLEANUP
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get clean
sudo apt-get autoremove --purge
sudo apt autoclean
