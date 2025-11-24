#!/usr/bin/env bash

PACKAGES="base
linux
linux-firmware
base-devel
intel-ucode
fwupd
neovim
sudo
networkmanager
iputils
man-db
man-pages
texinfo
curl
which
zsh
zsh-completions
xorg-server
xorg-apps
xorg-init
mesa"

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

	efibootmgr --create \
		--disk /dev/nvme0n1 --part 1 \
		--label "EFISTUB Arch" \
		--loader /vmlinuz-linux \
		--unicode "root=UUID=$(get_uuid) rw initrd=\initramfs-linux.img"
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
mesa
xmonad
xmonad-contrib
alacritty
xz
make
gmp
ncurses
brightnessctl"

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

function install_xmonad_pkgs () {
	sudo pacman -S git xorg-server xorg-apps xorg-xinit xorg-xmessage libx11 libxft libxinerama libxrandr libxss pkgconf
}

function install_ghcup () {
	curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
}


function build_xmonad () {
	mkdir -p ~/.config/xmonad && cd ~/.config/xmonad
	cat << EOF > xmonad.hs
import XMonad

main :: IO ()
main = xmonad def
EOF

	git clone https://github.com/xmonad/xmonad
	git clone https://github.com/xmonad/xmonad-contrib
}

function build_xmonad_cabal () {
	echo "packages: */*.cabal" > cabal.project
	cabal update
	cabal install --package-env=$HOME/.config/xmonad --lib base xmonad xmonad-contrib
	cabal install --package-env=$HOME/.config/xmonad xmonad
}

function install_xmonad () {
	mkdir -p ~/.config/xmonad && cd ~/.config/xmonad
	#cat << 'EOF' > xmonad.hs
	#import XMonad

	#main :: IO ()
	#main = xmonad def
	#EOF

	git clone https://github.com/xmonad/xmonad
	git clone https://github.com/xmonad/xmonad-contrib
}

function install_google_chrome () {
	mkdir ~/builds && cd ~/builds
	git clone https://aur.archlinux.org/google-chrome.git
	cd google-chrome
	makepkg -risc
}

function set_x_kbd_settings () {
	xset r rate 200 30
}

function set_touchpad_settings () {
	sudo xinput set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Tapping Enabled' 1
	sudo xinput set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Natural Scrolling Enabled' 1
}


