# 🚀 PIMP MY Debian

**PIMP MY Debian** is a simple Bash script to "pimp" your Debian installation by removing unnecessary software and installing a curated set of useful applications, tools, and fonts. Ideal for fresh installs or quick setups!

---

## 🛠️ Features

- Removes unwanted default packages (e.g., LibreOffice, Dragon Player, etc.)
- Installs essential software like:
  - Google Chrome
  - ONLYOFFICE
  - Steam
  - Bottles (via Flatpak)
  - Krita, VLC, Veracrypt, VirtualBox, and more
- Adds emoji font support (Noto Color Emoji)
- Includes system tools like BleachBit, XClicker, and Balena Etcher
- Automatically fixes missing dependencies
- Cleans up downloaded `.deb` files after install

---

## 📦 Packages Available for Install

- AnyDesk
- BleachBit
- Bottles (via Flatpak)
- Chromium
- ClipGrab (YouTube downloader)
- Current Kernel Headers
- Deluge
- DOSBox
- Emoji font (Noto Color Emoji)
- Enable NonFree Repo (contrib, non-free, non-free-firmware)
- FileZilla
- Google Chrome
- Krita
- MEGASync
- MeowSQL (AppImage)
- NAPS2
- ONLYOFFICE Desktop Editors
- OpenShot Video Editor
- PuTTY
- PulseAudio
- Python3 + utils (pip, tk)
- Remove Stock Packages (LibreOffice etc)
- RustDesk
- SAMBA Autofix
- ScummVM
- Steam Client
- VeraCrypt
- VLC Media Player
- VSCodium
- VYM (mind mapping)
- Waydroid
- Wine Staging HQ
- XClicker Auto Clicker
- Xpad (sticky notes)
- Xscreensaver Extra Data

---

## 📋 Requirements

- Debian (tested on Debian 13 KDE)
- Internet connection
- `sudo` privileges

---

## 🚀 Installation

1. **Download the script:**
```bash
git clone https://github.com/differentfun/pimp-my-debian.git
```
```bash
cd pimp-my-debian
```

Make it executable:

```bash
chmod +x pimp-my-debian.sh
```

Run the script:

```bash
./pimp-my-debian.sh
```

## 📌 Notes

The script will automatically download .deb files from official sources.

If you already have some of the apps installed, they will be skipped or updated accordingly.

Bottles is installed via Flatpak and may require a reboot or logout to appear in your menu.

🎉 Enjoy your upgraded Debian!
