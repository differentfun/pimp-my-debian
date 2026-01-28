#!/bin/bash

install_rustdesk() {
  echo "⬇️ Downloading RustDesk..."
  wget https://github.com/rustdesk/rustdesk/releases/download/1.4.5/rustdesk-1.4.5-x86_64.deb
  echo "📦 Installing RustDesk..."
  sudo dpkg -i rustdesk-1.4.5-x86_64.deb
  sudo apt --fix-broken install -y
}
