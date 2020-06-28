#!/bin/bash

echo_header "Ubuntu Configuration"
sudo apt-get -qq update



# -- Tools ----------------------------------------------------------------
echo_item "Installing some software needed for installing from source" "green"
sudo apt-get -qq install wget tar libevent-dev libncurses-dev make build-essential
echo ""


# -- Hardware ----------------------------------------------------------------
source "./hardware/hardware.sh"

# -- Curl  -----------------------------------------------------------------------
if exists "curl"; then
  echo_item "curl is already installed" "green"
else
  sudo apt-get -qq install curl
fi

echo ""



# -- zsh -----------------------------------------------------------------------
if exists "zsh"; then
  echo_item "zsh is already installed" green
else
  echo_item "Installing zsh" "green"
  sudo apt-get -qq install zsh
fi

echo ""



# -- nvm -----------------------------------------------------------------------
source 'nvm/nvm.sh'



# -- ruby ----------------------------------------------------------------------
if exists "rbenv"; then
  echo_item "Rbenv is already installed" "green"
else
 sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
 git clone https://github.com/rbenv/rbenv.git ~/.rbenv
 git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
 rbenv install 2.6.3
 rbenv global 2.6.3
 gem install bundler
 rbenv rehash
 gem install rails -v 6.0.0.rc1
 rbenv rehash
 gem install solargraph
fi

echo ""



# -- GO ------------------------------------------------------------------------
if exists "go"; then
  echo_item "Go is already installed" "green"
else
  mkdir ~/tmp
  cd ~/tmp
  curl -O https://dl.google.com/go/go1.14.1.linux-amd64.tar.gz
  tar xvf go1.14.1.linux-amd64.tar.gz
  sudo mv go /usr/local/bin/
  cd -
fi

echo ""



# -- Terraform -----------------------------------------------------------------
if exists "terraform"; then
  echo_item "Terraform is already installed" "green"
else
  "Installing Terraform"
  mkdir ~/tmp
  cd ~/tmp
  wget https://releases.hashicorp.com/terraform/0.11.14/terraform_0.11.14_linux_amd64.zip
  unzip terraform_0.11.14_linux_amd64.zip
  sudo mv terraform /usr/local/bin/
  cd -
fi

echo ""



# -- Terraform Languange Server ------------------------------------------------
if exists "terraform-lsp"; then
  echo_item "Terraform language server is already installed" "green"
else
  ech_item "Installing terraform language server" "green"
  cd ..
  git clone https://github.com/juliosueiras/terraform-lsp.git
  cd -
  cd ../terraform-lsp
  GO111MODULE=on go mod download
  make
  make copy
  cd -
fi

echo ""



# -- Neovim --------------------------------------------------------------------
source 'nvim/nvim.sh'



# -- Ripgrep --------------------------------------------------------------------
if exists "rg"; then
  echo_item "Ripgrep is already installed" "green"
else
  sudo add-apt-repository ppa:x4121/ripgrep
  sudo apt-get -qq update
  sudo apt-get -qq install ripgrep
fi

echo ""



# -- jq --------------------------------------------------------------------
if exists "jq"; then
  echo_item "jq is already installed" "green"
else
  sudo apt-get -qq install jq
fi

echo ""



# -- Tmux --------------------------------------------------------------------
source 'tmux/tmux.sh'



# -- Docker --------------------------------------------------------------------
source "./docker/docker.sh"



# -- Python --------------------------------------------------------------------
if exists "virtualenv"; then
  echo_item "Virtualenv already installed" "green"
else
  echo_item "Installing virtualenv" "green"
  sudo apt-get -qq install virtualenv
fi

echo ""



# -- Pipenv --------------------------------------------------------------------
if exists "pipenv"; then
  echo_item "Pipenv already installed" "green"
else
  echo_item "Installing pipenv" "green"
  sudo apt install python3-pip
  pip3 install pipenv
fi

echo ""



# -- Powerline Fonts -------------------------------------------------------------
if [[ -n $(find ~/.local/share/fonts -type f -name '*Powerline*') ]]; then
  echo_item "Powerline fonts are already installed" "green"
else
  git clone https://github.com/powerline/fonts.git --depth=1
  cd fonts
  ./install.sh
  cd -
  rm -rf fonts
fi

echo ""



# -- Gnome Tweaks ---------------------------------------------------------------
if exists "gnome-tweaks"; then
  echo_item "Gnome tweaks is already installed" "green"
else
  sudo apt-get -qq install gnome-tweaks
  sudo apt install gnome-shell-extension-autohidetopbar
fi

echo ""



# -- Xclip -----------------------------------------------------------------------
if exists "xclip"; then
  echo_item "Xclip is already installed" "green"
else
  sudo apt-get -qq install xclip
fi

echo ""



# -- Caffeine --------------------------------------------------------------------
if exists "caffeine"; then
  echo_item "Caffeine is already installed" "green"
else
  sudo apt-get -qq install caffeine
fi

echo ""



# -- Uninstall Unwanted Software -------------------------------------------------
echo_header "Removing unwanted software"



# -- Uninstall Thunderbird -------------------------------------------------------
if exists "thunderbird"; then
  echo_item "Uninstalling thunderbird" "green"
  sudo apt-get -qq remove thunderbird
else
  echo_item "Thunderbird is already uninstalled" "green"
fi

echo ""



# -- Uninstall Rhythmbox -------------------------------------------------------
if exists "rhythmbox"; then
  echo_item "Uninstalling Rhythmbox" "green"
  sudo apt-get -qq remove rhythmbox
else
  echo_item "Rhythmbox is already uninstalled" "green"
fi

echo ""



# -- Uninstall Mahjongg -------------------------------------------------------
if exists "gnome-mahjongg"; then
  echo_item "Uninstalling Mahjongg" "green"
  sudo apt-get -qq remove gnome-mahjongg
else
  echo_item "Mahjongg is already uninstalled" "green"
fi

echo ""



# -- Uninstall Mines -------------------------------------------------------
if exists "gnome-mines"; then
  echo_item "Uninstalling Mines" "green"
  sudo apt-get -qq remove gnome-mines
else
  echo_item "Mines is already uninstalled" "green"
fi

echo ""



# -- Scrolling --------------------------------------------------------------
echo_item "Turning off natural-scroll for the touchpad" "green"
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll false

echo ""



# -- Dock --------------------------------------------------------------------
echo_item "Executing dock configurations" "green"
source './dock/dock.sh'

echo ""



# -- Exfat support -----------------------------------------------------------
if [[ -f ~/.config/dotfile-installs/exfat ]]; then
  echo_item "Exfat support is already installed" "green"
else
  echo_item "Installing exfat support" "green"
  sudo apt install exfat-fuse exfat-utils
  sudo add-apt-repository universe
  touch ~/.config/dotfile-installs/exfat
fi

echo ""



# -- VLC -------------------------------------------------------------------
if exists "vlc"; then
  echo_item "VLC is already installed" "green"
else
  echo_item "Installing VLC" "green"
  sudo apt-get -qq install vlc
fi



# -- Enpass -----------------------------------------------------------------
ENPASS_FILE=~/.config/dotfile-installs/enpass
if [[ -f "$ENPASS_FILE" ]]; then
  echo_item "Enpass is already installed" "green"
else
  sudo sh -c 'echo "deb http://repo.sinew.in/ stable main" > /etc/apt/sources.list.d/enpass.list'
  wget -O - https://dl.sinew.in/keys/enpass-linux.key | sudo apt-key add -
  sudo apt -qq update
  sudo apt -qq install enpass -y
  touch ~/.config/dotfile-installs/enpass
fi



# -- Slack ------------------------------------------------------------------
if exists "slack"; then
  echo_item "Slack is already installed" "green"
else
  echo_item "Installing Slack" "green"
  sudo snap install slack --classic
fi

echo ""



# -- Firefox ----------------------------------------------------------------
if exists "firefox"; then
  echo_item "Firefox is already installed" "green"
else
  echo_item "Installing Firefox" "green"
  sudo apt-get -qq install firefox
fi

echo ""



# -- Blueman ----------------------------------------------------------------
if exists "blueman-manager"; then
  echo_item "Blueman is already installed" "green"
else
  echo_item "Installing Blueman" "green"
  sudo apt-get -qq install blueman
  sudo apt-get -qq install pulseaudio-module-bluetooth
fi

echo ""



# -- VPN -------------------------------------------------------------------
source './vpn/vpn.sh'



# -- Datagrip -----------------------------------------------------------------
if exists "datagrip"; then
  echo_item "Datagrip is already installed" "green"
else
  echo_item "Installing datagrip" "green"
  sudo snap install datagrip --classic
fi

echo ""



# -- Insomnia -----------------------------------------------------------------
if exists "insomnia"; then
  echo_item "Insomnia is already installed" "green"
else
  echo_item "Installing Insomnia" "green"
  echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list
      wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
        | sudo apt-key add -
              sudo apt-get -qq update
              sudo apt-get -qq install insomnia
fi

echo ""



# -- Heroku -------------------------------------------------------------------
if exists "heroku"; then
  echo_item "Heroku is already installed" "green"
else
  echo_item "Installing Heroku"
  sudo snap install --classic heroku
fi

echo ""



# -- Simple screen recorder ---------------------------------------------------
if exists "simplescreenrecorder"; then
  echo_item "Simple screen recorder is already installed" "green"
else
  echo_item "Installing Simple screen recorder"
  sudo apt install simplescreenrecorder
fi

echo ""



# -- NordVPN -------------------------------------------------------------------
if exists "nordvpn"; then
  echo_item "NordVPN is already installed" "green"
else
  echo_item "Installing NordVPN" "green"
  cd ~/Downloads
  sudo wget -qnc https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
  sudo dpkg -i ./nordvpn-release_1.0.0_all.deb
  sudo apt-get update
  sudo apt-get -qq install nordvpn
  cd -
fi

echo ""



# -- Bat ----------------------------------------------------------------------
if exists "bat"; then
  echo_item "Bat is already installed" "green"
else
  echo_item "Installing Bat" "green"
  sudo apt -qq install bat -y
  mkdir -p "$(bat --config-dir)/themes"
  ln -sf ~/dotfiles/bat/palenight.tmTheme "$(bat --config-dir)/themes/palenight.tmTheme"
  bat cache --build
fi

echo ""



# -- Gestures ------------------------------------------------------------------
source './gestures/gestures.sh'



# -- THEME -------------------------------------------------------------------------
source 'theme/theme.sh'



# -- TERMINAL ----------------------------------------------------------------------
source 'terminal/terminal.sh'



# -- ENVIRONMENT --------------------------------------------------------------------
source 'environment/environment.sh'



# -- Startup Scripts -------------------------------------------------------------------
source './startup/startup.sh'
