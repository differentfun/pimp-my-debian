#!/bin/bash

install_pi_imager() {
  echo "⬇️ Raspberry PI Imager..."
  wget https://downloads.raspberrypi.com/imager/imager_latest_amd64.deb
  echo "📦 Raspberry PI Imager..."
  sudo dpkg -i imager_latest_amd64.deb
  sudo apt --fix-broken install -y
}
