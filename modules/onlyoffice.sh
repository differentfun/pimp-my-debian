#!/bin/bash

install_onlyoffice() {
  echo "⬇️ Downloading ONLYOFFICE..."
  wget https://github.com/ONLYOFFICE/DesktopEditors/releases/latest/download/onlyoffice-desktopeditors_amd64.deb
  echo "📦 Installing ONLYOFFICE..."
  sudo dpkg -i onlyoffice-desktopeditors_amd64.deb
  sudo apt --fix-broken install -y
}
