#!/bin/bash

install_steam() {
  echo "⬇️ Downloading Steam..."
  wget https://cdn.fastly.steamstatic.com/client/installer/steam.deb
  echo "📦 Installing Steam..."
  sudo dpkg -i steam.deb
  sudo apt --fix-broken install -y
}
