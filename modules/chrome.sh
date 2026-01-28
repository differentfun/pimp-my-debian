#!/bin/bash

install_chrome() {
  echo "⬇️ Downloading Google Chrome..."
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  echo "📦 Installing Google Chrome..."
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  sudo apt --fix-broken install -y
}
