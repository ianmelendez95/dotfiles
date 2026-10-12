#!/usr/bin/env bash

# README!!!
# Double check the intel video drivers,
# I don't think newer gens are compatible with xf86-video-intel

PACKAGES="base
linux
linux-firmware
base-devel
amd-ucode
mesa
efibootmgr
alsa-utils
sof-firmware
pipewire
pipewire-pulse
pipewire-alsa
wireplumber
networkmanager
iputils
man-db
man-pages
texinfo
curl
git
sudo
neovim
which
zsh
zsh-completions
noto-fonts
noto-fonts-emoji
otf-font-awesome"

function common_check_ping () {
	echo "Checking connectivity"
	ping -c 1 ping.archlinux.org &> /dev/null
	if [ $? -eq 0 ]; then
		echo "SUCCESS: connected"
	else
		echo "ERROR: could not ping"
		exit 1
	fi
}

function bs_wifi_connect () {
	iwctl station wlan0 scan
	iwctl --passphrase 2107246720 station wlan0 connect ItBurnsWhenIP
	common_check_ping
}

function bs_install_packages () { 
	pacstrap -K /mnt $(echo "$PACKAGES" | xargs)
}

function bs_get_uuid () {
	blkid | grep 'nvme0n1p3' | awk '{ print $2 }' | sed 's/UUID="\(.*\)"/\1/g'
}

function bs_setup_uefi () {
	echo "Setting up UEFI boot record"

	bootctl install
}

function bs_setup_loaders () {
	# Copy the arch.conf from systemd
	# Get the UUID using bs_get_uuid
	# Follow instructions in Systemd-boot#Adding_loaders page
}

function setup_user () {
	echo "Setup sudoers"
	visudo # setup the sudo group

	useradd -m -s /usr/bin/zsh -G sudo imelendez

	echo "Prompting password..."
	passwd imelendez

	cp /etc/X11/xinit/xinitrc /home/imelendez/.xinitrc
}

# After reboot

USER_PACKAGES="git
openssh
xorg-server
xorg-apps
xorg-init
xsettingsd
mesa
kitty
xz
make
cmake
gmp
ncurses
brightnessctl
ripgrep
fd"

function wifi_connect () {
	echo "Enabling NetworkManager"
	systemctl enable NetworkManager
	systemctl start NetworkManager

	echo "Connecting to network"
	nmcli device wifi connect ItBurnsWhenIP # password 2107246720

	common_check_ping
}

function install_user_packages () {
	pacman -S $(echo "$USER_PACKAGES" | xargs)
}

function install_google_chrome () {
	mkdir ~/builds && cd ~/builds
	git clone https://aur.archlinux.org/google-chrome.git
	cd google-chrome
	makepkg -risc
}

function install_omzsh () {
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function install_paru () {
  # Use the official instructions
}


# Wayland setup

WAYLAND_PACKAGES="hyprland
aquamarine
polkit
mako
dolphin
waybar
hip-runtime-amd
steam
lib32-vulkan-radeon
hypridle
libnotify
xdg-desktop-portal-hyprland
xdg-desktop-portal-gtk
hyprpolkitagent
hyprpaper
hyprlauncher
wl-clipboard
sddm
qt5-wayland
qt6-wayland
qt5-declarative"

function setup_sddm () {
  systemctl enable sddm
}

function setup_nvim () {
  git clone https://github.com/neovim/nvim-lspconfig ~/.config/nvim/pack/nvim/start/nvim-lspconfig
}

function setup_xdg_desktop_portal () {
  pacman
}

function setup_hyprpolkitagent () {
  systemctl --user enable hyprpolkitagent
  systemctl --user start hyprpolkitagent
}
