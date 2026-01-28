#!/bin/bash

install_waydroid() {
  echo "📦 Installing Waydroid..."
  curl -s https://repo.waydro.id | sudo bash -s trixie
  sudo apt update
  sudo apt install -y waydroid
  sudo apt --fix-broken install -y
}
