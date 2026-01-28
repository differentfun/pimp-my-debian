#!/bin/bash

cleanup_downloads() {
  echo "🗑️ Cleaning up downloaded files..."
  rm -f steam.deb onlyoffice-desktopeditors_amd64.deb google-chrome-stable_current_amd64.deb
  rm -f xclicker_1.5.1_amd64.deb imager_latest_amd64.deb megasync-Debian_13_amd64.deb
  rm -f rustdesk-1.4.5-x86_64.deb
  rm -f anydesk_7.1.3-1_amd64.deb
  rm -f naps2-8.2.1-linux-x64.deb
  rm -f veracrypt-1.26.24-Debian-13-amd64.deb
}
