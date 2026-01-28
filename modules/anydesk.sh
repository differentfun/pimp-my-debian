#!/bin/bash

install_anydesk() {
  echo "⬇️ Downloading AnyDesk..."
  wget https://download.anydesk.com/linux/anydesk_7.1.3-1_amd64.deb
  echo "📦 Installing AnyDesk..."
  sudo dpkg -i anydesk_7.1.3-1_amd64.deb
  sudo apt --fix-broken install -y
}
