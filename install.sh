set -e

sudo apt update -y
sudo apt upgrade -y
sudo apt install -y \
	curl git unzip wget build-essential pkg-config autoconf bison clang \
	libssl-dev libreadline-dev zlib1g-dev libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev libjemalloc2 \
	libvips imagemagick libmagickwand-dev mupdf mupdf-tools \
	redis-tools sqlite3 libsqlite3-0 fzf ripgrep bat eza zoxide plocate btop apache2-utils fd-find \
    software-properties-common zsh gnome-tweaks gnome-shell-extension-manager virt-manager qemu-kvm mc \
    ca-certificates chromium vlc virt-manager 


# Docker 
sudo apt install -y docker.io docker-buildx containerd.io docker-buildx-plugin docker-compose-plugin 
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

# Gives you previews in the file manager when pressing space
sudo apt install -y gnome-sushi
sudo apt install -y gnome-tweak-tool

# Typora
wget -qO - https://typora.io/linux/public-key.asc | sudo tee /etc/apt/trusted.gpg.d/typora.asc
sudo add-apt-repository -y 'deb https://typora.io/linux ./'
sudo apt update
sudo apt install -y typora

# Misc tools and apps
sudo apt install -y vlc gnome-shell-extension-manager gnome-shell-extension

# Visual Studio Code
cd /tmp
wget -O code.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
sudo apt install -y ./code.deb
rm code.deb
cd -

# Add local fonts
mkdir -p ~/.local/share/fonts

cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
unzip CascadiaMono.zip -d CascadiaFont
cp CascadiaFont/*.ttf ~/.local/share/fonts
rm -rf CascadiaMono.zip CascadiaFont

wget -O iafonts.zip https://github.com/iaolo/iA-Fonts/archive/refs/heads/master.zip
unzip iafonts.zip -d iaFonts
cp iaFonts/iA-Fonts-master/iA\ Writer\ Mono/Static/iAWriterMonoS-*.ttf ~/.local/share/fonts
rm -rf iafonts.zip iaFonts
sudo fc-cache -f -v

# ADD GLOBAL THEMES
cd /usr/share/themes
sudo git clone https://github.com/EliverLara/Ant
sudo git clone https://github.com/EliverLara/Nordic

# ADD GLOBAL FONTS
sudo wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
sudo unzip JetBrainsMono.zip -d /usr/share/fonts/
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

# Gnome Theme Settings
THEME_FOLDER = "$HOME/.local/share/ubuntu-code/nord"
BACKGROUND = "$THEME_FOLDER/background.png"

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Yaru'
gsettings set org.gnome.desktop.interface gtk-theme "Yaru-blue-dark"
gsettings set org.gnome.desktop.interface icon-theme "Yaru-blue"
gsettings set org.gnome.desktop.background picture-uri $BACKGROUND
gsettings set org.gnome.desktop.background picture-uri-dark $BACKGROUND
gsettings set org.gnome.desktop.background picture-options 'zoom'


# CLEANUP
sudo apt-get clean
sudo apt-get autoremove --purge


sudo curl -sS https://starship.rs/install.sh | sh
echo eval "$(starship init zsh)" >> ~/.zshrc
starship preset pastel-powerline -o ~/.config/starship.toml