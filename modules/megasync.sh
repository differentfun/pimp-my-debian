#!/bin/bash

install_megasync() {
  echo "⬇️ Downloading MEGAsync..."
  wget https://mega.nz/linux/repo/Debian_13/amd64/megasync-Debian_13_amd64.deb
  echo "📦 Installing MEGAsync..."
  sudo dpkg -i megasync-Debian_13_amd64.deb
  sudo apt --fix-broken install -y
}
