#!/bin/bash

install_wine() {
  echo "Removing existing Wine installations..."
  sudo apt remove --purge wine* libwine* -y
  sudo apt autoremove --purge -y

  echo "Adding i386 architecture..."
  sudo dpkg --add-architecture i386

  echo "Adding WineHQ GPG key..."
  sudo mkdir -pm755 /etc/apt/keyrings
  sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

  echo "Adding WineHQ repo for Debian Trixie..."
  sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/trixie/winehq-trixie.sources

  echo "Updating APT..."
  sudo apt update

  echo "Installing Wine Staging..."
  sudo apt install --install-recommends winehq-staging -y
  sudo apt --fix-broken install -y
}
