#!/bin/bash

install_xclicker() {
  echo "⬇️ Downloading XClicker..."
  wget https://github.com/robiot/xclicker/releases/download/v1.5.1/xclicker_1.5.1_amd64.deb
  echo "📦 Installing XClicker..."
  sudo dpkg -i xclicker_1.5.1_amd64.deb
  sudo apt --fix-broken install -y
}
