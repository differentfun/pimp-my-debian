#!/bin/bash

install_veracrypt() {
  echo "⬇️ Downloading VeraCrypt..."
  wget https://launchpad.net/veracrypt/trunk/1.26.24/+download/veracrypt-1.26.24-Debian-13-amd64.deb
  echo "📦 Installing VeraCrypt..."
  sudo dpkg -i veracrypt-1.26.24-Debian-13-amd64.deb
  sudo apt --fix-broken install -y
}
