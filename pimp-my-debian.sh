#!/bin/bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# shellcheck source=modules/common.sh
source "$SCRIPT_DIR/modules/common.sh"
# shellcheck source=modules/selection.sh
source "$SCRIPT_DIR/modules/selection.sh"
# shellcheck source=modules/system_prep.sh
source "$SCRIPT_DIR/modules/system_prep.sh"
# shellcheck source=modules/wine.sh
source "$SCRIPT_DIR/modules/wine.sh"
# shellcheck source=modules/onlyoffice.sh
source "$SCRIPT_DIR/modules/onlyoffice.sh"
# shellcheck source=modules/steam.sh
source "$SCRIPT_DIR/modules/steam.sh"
# shellcheck source=modules/chrome.sh
source "$SCRIPT_DIR/modules/chrome.sh"
# shellcheck source=modules/megasync.sh
source "$SCRIPT_DIR/modules/megasync.sh"
# shellcheck source=modules/xclicker.sh
source "$SCRIPT_DIR/modules/xclicker.sh"
# shellcheck source=modules/pi_imager.sh
source "$SCRIPT_DIR/modules/pi_imager.sh"
# shellcheck source=modules/vscodium.sh
source "$SCRIPT_DIR/modules/vscodium.sh"
# shellcheck source=modules/rustdesk.sh
source "$SCRIPT_DIR/modules/rustdesk.sh"
# shellcheck source=modules/anydesk.sh
source "$SCRIPT_DIR/modules/anydesk.sh"
# shellcheck source=modules/veracrypt.sh
source "$SCRIPT_DIR/modules/veracrypt.sh"
# shellcheck source=modules/naps2.sh
source "$SCRIPT_DIR/modules/naps2.sh"
# shellcheck source=modules/meowsql.sh
source "$SCRIPT_DIR/modules/meowsql.sh"
# shellcheck source=modules/openshot.sh
source "$SCRIPT_DIR/modules/openshot.sh"
# shellcheck source=modules/bottles.sh
source "$SCRIPT_DIR/modules/bottles.sh"
# shellcheck source=modules/cleanup.sh
source "$SCRIPT_DIR/modules/cleanup.sh"
# shellcheck source=modules/waydroid.sh
source "$SCRIPT_DIR/modules/waydroid.sh"
# shellcheck source=modules/samba_autofix.sh
source "$SCRIPT_DIR/modules/samba_autofix.sh"

ensure_zenity
if ! SELECTION=$(show_selection); then
  exit 1
fi
IFS=":" read -ra SOFTWARE <<< "$SELECTION"

GPU_VENDOR=$(detect_gpu_vendor)

system_prep

if is_selected "nonfree-repo"; then
  enable_nonfree_repo
fi

if is_selected "Remove Stock Packages"; then
  remove_stock_packages
fi

if is_selected "wine"; then
  install_wine
fi

if is_selected "krita"; then
  install_apt_app "Krita" krita
fi

if is_selected "rustdesk"; then
  install_rustdesk
fi

if is_selected "anydesk"; then
  install_anydesk
fi

if is_selected "naps2"; then
  install_naps2
fi

if is_selected "filezilla"; then
  install_apt_app "FileZilla" filezilla
fi

if is_selected "putty"; then
  install_apt_app "PuTTY" putty
fi

if is_selected "vlc"; then
  install_apt_app "VLC" vlc
fi

if is_selected "vym"; then
  install_apt_app "VYM" vym
fi

if is_selected "deluge"; then
  install_apt_app "Deluge" deluge
fi

if is_selected "bleachbit"; then
  install_apt_app "BleachBit" bleachbit
fi

if is_selected "xscreensaver"; then
  install_apt_app "Xscreensaver Extra Data" xscreensaver-data-extra
fi

if is_selected "veracrypt"; then
  install_veracrypt
fi

if is_selected "pulseaudio"; then
  install_apt_app "PulseAudio" pulseaudio
fi

if is_selected "unrar"; then
  install_apt_app "Unrar" unrar
fi

if is_selected "clipgrab"; then
  install_apt_app "ClipGrab" clipgrab
fi

if is_selected "dosbox"; then
  install_apt_app "DOSBox" dosbox
fi

if is_selected "scummvm"; then
  install_apt_app "ScummVM" scummvm
fi

if is_selected "fonts-noto-color-emoji"; then
  install_apt_app "emoji font" fonts-noto-color-emoji
fi

if is_selected "python3-utils"; then
  install_apt_app "Python3 + utils" python3-pip python3-tk
fi

if is_selected "kernel-headers"; then
  install_apt_app "Current Kernel Headers" "linux-headers-$(uname -r)"
fi

if is_selected "onlyoffice"; then
  install_onlyoffice
fi

if is_selected "steam"; then
  install_steam
fi

if is_selected "chrome"; then
  install_chrome
fi

if is_selected "chromium"; then
  install_apt_app "Chromium" chromium
fi

if is_selected "megasync"; then
  install_megasync
fi

if is_selected "vscodium"; then
  install_vscodium
fi

if is_selected "xclicker"; then
  install_xclicker
fi

if is_selected "pi-imager"; then
  install_pi_imager
fi

if is_selected "meowsql"; then
  install_meowsql
fi

if is_selected "openshot"; then
  install_openshot
fi

cleanup_downloads

if is_selected "bottles"; then
  install_bottles
fi

if is_selected "xpad"; then
  install_apt_app "xpad (Sticky Notes)" xpad
fi

if is_selected "waydroid"; then
  install_waydroid
fi

if is_selected "samba-autofix"; then
  install_samba_autofix
fi

echo ""
echo "✅ Done! Debian has been pimped based on your selection. Enjoy!"
