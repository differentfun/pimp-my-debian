#!/bin/bash

install_naps2() {
  echo "⬇️ Downloading NAPS2..."
  wget https://github.com/cyanfish/naps2/releases/download/v8.2.1/naps2-8.2.1-linux-x64.deb
  echo "📦 Installing NAPS2..."
  sudo dpkg -i naps2-8.2.1-linux-x64.deb
  sudo apt --fix-broken install -y
}
