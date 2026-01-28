#!/bin/bash

system_prep() {
  echo "🚀 Starting PIMP for Debian..."

  echo "🔄 Updating package list..."
  sudo dpkg --add-architecture i386
  sudo apt update
}

enable_nonfree_repo() {
  echo "🧩 Enabling contrib and non-free repositories..."
  if grep -Eqs '^[[:space:]]*deb(-src)?[[:space:]].*\\bmain\\b' /etc/apt/sources.list \
    && ! grep -Eqs '^[[:space:]]*deb(-src)?[[:space:]].*\\bcontrib\\b' /etc/apt/sources.list \
    && ! grep -Eqs '^[[:space:]]*deb(-src)?[[:space:]].*\\bnon-free\\b' /etc/apt/sources.list; then
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo sed -i \
      -e 's/\\bmain\\b\\s*$/main contrib non-free/' \
      -e 's/\\bmain\\b\\s+contrib\\s*$/main contrib non-free/' \
      -e 's/\\bmain\\b\\s+non-free\\s*$/main contrib non-free/' \
      /etc/apt/sources.list
  fi

  if grep -Eqs '^[[:space:]]*deb(-src)?[[:space:]].*\\bmain\\b' /etc/apt/sources.list \
    && ! grep -Eqs '^[[:space:]]*deb(-src)?[[:space:]].*\\bnon-free-firmware\\b' /etc/apt/sources.list; then
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
    sudo sed -i \
      -e 's/\\bmain\\b\\s*$/main non-free-firmware/' \
      -e 's/\\bmain\\b\\s+non-free\\s*$/main non-free non-free-firmware/' \
      -e 's/\\bmain\\b\\s+contrib\\s*$/main contrib non-free-firmware/' \
      -e 's/\\bmain\\b\\s+contrib\\s+non-free\\s*$/main contrib non-free non-free-firmware/' \
      /etc/apt/sources.list
  fi
  sudo apt update
}

remove_stock_packages() {
  echo "🧹 Removing stock packages..."
  sudo apt remove -y gimp libreoffice* kmail dragonplayer juk kaddressbook
  sudo apt autoremove -y
}
