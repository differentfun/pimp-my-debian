#!/bin/bash

show_selection() {
  local selection
  selection=$(zenity --list --title="DEBIAN PIMP - Select Software to Install" \
    --text="Uncheck anything you don't want to install." \
    --checklist \
    --width=600 --height=600 \
    --column="Selected" --column="Software" --column="Description" \
    TRUE "anydesk" "AnyDesk" \
    TRUE "bleachbit" "BleachBit (system cleaner)" \
    TRUE "bottles" "Bottles (via Flatpak)" \
    TRUE "chrome" "Google Chrome" \
    TRUE "chromium" "Chromium" \
    TRUE "clipgrab" "ClipGrab (YouTube downloader)" \
    TRUE "deluge" "Deluge BitTorrent client" \
    TRUE "dosbox" "DOSBox" \
    TRUE "filezilla" "FileZilla" \
    TRUE "fonts-noto-color-emoji" "Emoji font" \
    TRUE "kernel-headers" "Current Kernel Headers" \
    TRUE "krita" "Krita" \
    TRUE "megasync" "MEGASync" \
    TRUE "meowsql" "MeowSQL (AppImage)" \
    TRUE "naps2" "NAPS2" \
    TRUE "nonfree-repo" "Enable NonFree Repo" \
    TRUE "onlyoffice" "ONLYOFFICE Desktop Editors" \
    TRUE "openshot" "OpenShot Video Editor" \
    TRUE "pi-imager" "Raspberry PI Imager" \
    TRUE "pulseaudio" "PulseAudio" \
    TRUE "python3-utils" "Python3 + utils (pip, tk)" \
    TRUE "Remove Stock Packages" "Libreoffice etc" \
    TRUE "rustdesk" "RustDesk" \
    TRUE "samba-autofix" "Installa and Autofix SAMBA" \
    TRUE "scummvm" "ScummVM" \
    TRUE "steam" "Steam Client" \
    TRUE "vscodium" "VSCodium" \
    TRUE "veracrypt" "VeraCrypt" \
    TRUE "vlc" "VLC Media Player" \
    TRUE "vym" "VYM (mind mapping)" \
    TRUE "waydroid" "Waydroid" \
    TRUE "wine" "Wine Staging HQ" \
    TRUE "xclicker" "XClicker Auto Clicker" \
    TRUE "xpad" "Xpad (sticky notes)" \
    TRUE "xscreensaver" "Xscreensaver Extra Data" \
    --separator=":" 2>/dev/null)

  if [ $? -ne 0 ]; then
    echo "❌ Installation canceled." >&2
    return 1
  fi

  echo "$selection"
}
