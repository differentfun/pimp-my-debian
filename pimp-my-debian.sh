#!/bin/bash

# Display Zenity checklist with default selections
SELECTION=$(zenity --list --title="DEBIAN PIMP - Select Software to Install" \
  --text="Uncheck anything you don't want to install." \
  --checklist \
  --width=600 --height=600 \
  --column="Selected" --column="Software" --column="Description" \
  TRUE "wine" "Wine Staging HQ" \
  TRUE "onlyoffice" "ONLYOFFICE Desktop Editors" \
  TRUE "steam" "Steam Client" \
  TRUE "chrome" "Google Chrome" \
  TRUE "megasync" "MEGASync" \
  TRUE "xclicker" "XClicker Auto Clicker" \
  TRUE "pi-imager" "Raspberry PI Imager" \
  TRUE "meowsql" "MeowSQL (AppImage)" \
  TRUE "openshot" "OpenShot Video Editor" \
  TRUE "bottles" "Bottles (via Flatpak)" \
  TRUE "krita" "Krita" \
  TRUE "filezilla" "FileZilla" \
  TRUE "putty" "PuTTY" \
  TRUE "vlc" "VLC Media Player" \
  TRUE "vym" "VYM (mind mapping)" \
  TRUE "deluge" "Deluge BitTorrent client" \
  TRUE "virtualbox" "VirtualBox" \
  TRUE "bleachbit" "BleachBit (system cleaner)" \
  TRUE "xscreensaver" "Xscreensaver Extra Data" \
  TRUE "veracrypt" "VeraCrypt" \
  TRUE "pulseaudio" "PulseAudio" \
  TRUE "clipgrab" "ClipGrab (YouTube downloader)" \
  TRUE "dosbox" "DOSBox" \
  TRUE "scummvm" "ScummVM" \
  TRUE "fonts-noto-color-emoji" "Emoji font" \
  TRUE "vscodium" "VSCodium" \
  TRUE "xpad" "Xpad (sticky notes)" \
  TRUE "waydroid" "Waydroid" \
  --separator=":")

# Exit if user cancels
if [ $? -ne 0 ]; then
  echo "❌ Installation canceled."
  exit 1
fi

# Parse the selected options
IFS=":" read -ra SOFTWARE <<< "$SELECTION"

# Function to check if a component is selected
is_selected() {
  [[ " ${SOFTWARE[@]} " =~ " $1 " ]]
}

echo "🚀 Starting PIMP for Debian..."

# Remove unwanted packages
echo "🧹 Removing unnecessary packages..."
sudo apt remove -y gimp libreoffice* kmail dragonplayer juk kaddressbook
sudo apt autoremove -y

# Update package list
echo "🔄 Updating package list..."
sudo dpkg --add-architecture i386
sudo apt update

# Wine installation
if is_selected "wine"; then
  echo "Removing existing Wine installations..."
  sudo apt remove --purge wine* libwine* -y
  sudo apt autoremove --purge -y

  echo "Adding i386 architecture..."
  sudo dpkg --add-architecture i386

  echo "Adding WineHQ GPG key..."
  sudo mkdir -pm755 /etc/apt/keyrings
  sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key

  echo "Adding WineHQ repo for Debian Trixie..."
  sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/trixie/winehq-trixie.sources

  echo "Updating APT..."
  sudo apt update

  echo "Installing Wine Staging..."
  sudo apt install --install-recommends winehq-staging -y
  sudo apt --fix-broken install -y
fi

# Individual app installations
if is_selected "krita"; then
  echo "📦 Installing Krita..."
  sudo apt install -y krita
  sudo apt --fix-broken install -y
fi

if is_selected "filezilla"; then
  echo "📦 Installing FileZilla..."
  sudo apt install -y filezilla
  sudo apt --fix-broken install -y
fi

if is_selected "putty"; then
  echo "📦 Installing PuTTY..."
  sudo apt install -y putty
  sudo apt --fix-broken install -y
fi

if is_selected "vlc"; then
  echo "📦 Installing VLC..."
  sudo apt install -y vlc
  sudo apt --fix-broken install -y
fi

if is_selected "vym"; then
  echo "📦 Installing VYM..."
  sudo apt install -y vym
  sudo apt --fix-broken install -y
fi

if is_selected "deluge"; then
  echo "📦 Installing Deluge..."
  sudo apt install -y deluge
  sudo apt --fix-broken install -y
fi

if is_selected "virtualbox"; then
  echo "📦 Installing VirtualBox..."
  sudo apt install -y virtualbox-qt
  sudo apt --fix-broken install -y
  echo "📦 Fixing VirtualBox No-USB Bug..."
  sudo usermod -aG vboxusers $USER
fi

if is_selected "bleachbit"; then
  echo "📦 Installing BleachBit..."
  sudo apt install -y bleachbit
  sudo apt --fix-broken install -y
fi

if is_selected "xscreensaver"; then
  echo "📦 Installing Xscreensaver Extra Data..."
  sudo apt install -y xscreensaver-data-extra
  sudo apt --fix-broken install -y
fi

if is_selected "veracrypt"; then
  echo "📦 Installing VeraCrypt..."
  sudo apt install -y veracrypt
  sudo apt --fix-broken install -y
fi

if is_selected "pulseaudio"; then
  echo "📦 Installing PulseAudio..."
  sudo apt install -y pulseaudio
  sudo apt --fix-broken install -y
fi

if is_selected "clipgrab"; then
  echo "📦 Installing ClipGrab..."
  sudo apt install -y clipgrab
  sudo apt --fix-broken install -y
fi

if is_selected "dosbox"; then
  echo "📦 Installing DOSBox..."
  sudo apt install -y dosbox
  sudo apt --fix-broken install -y
fi

if is_selected "scummvm"; then
  echo "📦 Installing ScummVM..."
  sudo apt install -y scummvm
  sudo apt --fix-broken install -y
fi

if is_selected "fonts-noto-color-emoji"; then
  echo "📦 Installing emoji font..."
  sudo apt install -y fonts-noto-color-emoji
  sudo apt --fix-broken install -y
fi

# ONLYOFFICE
if is_selected "onlyoffice"; then
  echo "⬇️ Downloading ONLYOFFICE..."
  wget https://github.com/ONLYOFFICE/DesktopEditors/releases/latest/download/onlyoffice-desktopeditors_amd64.deb
  echo "📦 Installing ONLYOFFICE..."
  sudo dpkg -i onlyoffice-desktopeditors_amd64.deb
  sudo apt --fix-broken install -y
fi

# Steam
if is_selected "steam"; then
  echo "⬇️ Downloading Steam..."
  wget https://cdn.fastly.steamstatic.com/client/installer/steam.deb
  echo "📦 Installing Steam..."
  sudo dpkg -i steam.deb
  sudo apt --fix-broken install -y
fi

# Google Chrome
if is_selected "chrome"; then
  echo "⬇️ Downloading Google Chrome..."
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  echo "📦 Installing Google Chrome..."
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  sudo apt --fix-broken install -y
fi

# MEGAsync
if is_selected "megasync"; then
  echo "⬇️ Downloading MEGAsync..."
  wget https://mega.nz/linux/repo/Debian_13/amd64/megasync-Debian_13_amd64.deb
  echo "📦 Installing MEGAsync..."
  sudo dpkg -i megasync-Debian_13_amd64.deb
  sudo apt --fix-broken install -y
fi

# VSCodium
if is_selected "vscodium"; then
  echo "⬇️ Enabling VSCodium Repo..."
  wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
  
  echo 'deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

  echo "📦 Installing VSCodium..."
  sudo apt update && sudo apt install -y codium
  sudo apt --fix-broken install -y
fi

# XClicker
if is_selected "xclicker"; then
  echo "⬇️ Downloading XClicker..."
  wget https://github.com/robiot/xclicker/releases/download/v1.5.1/xclicker_1.5.1_amd64.deb
  echo "📦 Installing XClicker..."
  sudo dpkg -i xclicker_1.5.1_amd64.deb
  sudo apt --fix-broken install -y
fi

# Raspberry PI Imager
if is_selected "pi-imager"; then
  echo "⬇️ Raspberry PI Imager..."
  wget https://downloads.raspberrypi.com/imager/imager_latest_amd64.deb
  echo "📦 Raspberry PI Imager..."
  sudo dpkg -i imager_latest_amd64.deb
  sudo apt --fix-broken install -y
fi

# MeowSQL
if is_selected "meowsql"; then
  echo "⬇️ Downloading MeowSQL AppImage..."
  wget -O MeowSQL.AppImage https://github.com/ragnar-lodbrok/meow-sql/releases/download/v0.4.18-alpha/Linux_MeowSQL_0.4.18-x86_64.AppImage

  echo "📦 Installing MeowSQL to /opt..."
  sudo mv MeowSQL.AppImage /opt/MeowSQL.AppImage
  sudo chmod +x /opt/MeowSQL.AppImage

  echo "🖥️ Creating menu entry for MeowSQL..."
  cat <<EOF | sudo tee /usr/share/applications/meowsql.desktop > /dev/null
[Desktop Entry]
Name=MeowSQL
Comment=Database client similar to DBeaver
Exec=/opt/MeowSQL.AppImage
Icon=utilities-terminal
Terminal=false
Type=Application
Categories=Development;Database;
EOF
fi

# OpenShot
if is_selected "openshot"; then
  echo "⬇️ Downloading OpenShot AppImage..."
  wget -O OpenShot.AppImage https://github.com/OpenShot/openshot-qt/releases/download/daily/OpenShot-v3.4.0-release-candidate-14124-6cea273b-0b018e34-x86_64.AppImage

  echo "📦 Installing OpenShot to /opt..."
  sudo mv OpenShot.AppImage /opt/OpenShot.AppImage
  sudo chmod +x /opt/OpenShot.AppImage

  echo "🖥️ Creating menu entry for OpenShot..."
  cat <<EOF | sudo tee /usr/share/applications/openshot.desktop > /dev/null
[Desktop Entry]
Name=OpenShot Video Editor
Comment=Simple and powerful video editor
Exec=/opt/OpenShot.AppImage
Icon=video-x-generic
Terminal=false
Type=Application
Categories=AudioVideo;Video;Editing;
EOF
fi

# Clean up downloaded .deb files
echo "🗑️ Cleaning up downloaded files..."
rm -f steam.deb onlyoffice-desktopeditors_amd64.deb google-chrome-stable_current_amd64.deb
rm -f xclicker_1.5.1_amd64.deb imager_latest_amd64.deb megasync-Debian_13_amd64.deb

# Bottles installation
if is_selected "bottles"; then
  echo "📦 Installing Flatpak and Bottles..."
  sudo apt install -y flatpak
  sudo apt --fix-broken install -y
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  sudo flatpak install -y flathub com.usebottles.bottles
  sudo apt install -y libvkd3d1 libvkd3d-shader1 mesa-vulkan-drivers mesa-vulkan-drivers:i386 vulkan-tools
  sudo apt install -y libvulkan1 libvulkan1:i386 libgl1-mesa-dri libgl1-mesa-dri:i386 libasound2 libasound2:i386 gstreamer1.0-plugins-base gstreamer1.0-plugins-base:i386 gstreamer1.0-plugins-good gstreamer1.0-plugins-good:i386
  sudo apt --fix-broken install -y
  sudo usermod -aG render $USER
  flatpak override --user --filesystem=$HOME com.usebottles.bottles
  APP_ID="com.usebottles.bottles"

  echo "⬇️ Preparing VKD3D component for Bottles..."
  BOTTLES_DATA_DIR="$HOME/.var/app/com.usebottles.bottles/data/bottles"
  mkdir -p "$BOTTLES_DATA_DIR/vkd3d"

  if command -v python3 >/dev/null 2>&1; then
    if VKD3D_URL=$(curl -sf https://api.github.com/repos/bottlesdevs/components/releases | python3 -c 'import json, sys
data = json.load(sys.stdin)
for release in data:
    for asset in release.get("assets", []):
        name = asset.get("name", "")
        if name.startswith("vkd3d-proton") and name.endswith(".tar.gz"):
            print(asset["browser_download_url"])
            raise SystemExit
sys.exit(1)' 2>/dev/null); then
      TMP_VKD3D_DIR=$(mktemp -d)
      if curl -L --fail -o "$TMP_VKD3D_DIR/vkd3d.tar.gz" "$VKD3D_URL"; then
        if tar -C "$TMP_VKD3D_DIR" -xzf "$TMP_VKD3D_DIR/vkd3d.tar.gz"; then
          EXTRACTED_DIR=$(find "$TMP_VKD3D_DIR" -mindepth 1 -maxdepth 1 -type d -print -quit)
          if [ -n "$EXTRACTED_DIR" ]; then
            VKD3D_PACK_NAME=$(basename "$EXTRACTED_DIR")
            DEST_DIR="$BOTTLES_DATA_DIR/vkd3d/$VKD3D_PACK_NAME"
            rm -rf "$DEST_DIR"
            mv "$EXTRACTED_DIR" "$BOTTLES_DATA_DIR/vkd3d/" && echo "✅ VKD3D pronto: $VKD3D_PACK_NAME"

            if [ -d "$BOTTLES_DATA_DIR/bottles" ]; then
              for bottle_path in "$BOTTLES_DATA_DIR"/bottles/*; do
                [ -d "$bottle_path" ] || continue
                bottle_name=$(basename "$bottle_path")
                echo "🔧 Aggiorno la bottle \"$bottle_name\" con VKD3D..."
                flatpak run --command=bottles-cli "$APP_ID" edit -b "$bottle_name" --vkd3d "$VKD3D_PACK_NAME" || echo "⚠️ Impossibile aggiornare la bottle \"$bottle_name\""
              done
            fi
          else
            echo "⚠️ Estratto VKD3D ma non trovo la directory risultante, passo oltre."
          fi
        else
          echo "⚠️ Impossibile estrarre l'archivio VKD3D."
        fi
      else
        echo "⚠️ Download del componente VKD3D non riuscito."
      fi
      rm -rf "$TMP_VKD3D_DIR"
    else
      echo "⚠️ Nessun asset VKD3D trovato sull'API di Bottles, installazione manuale richiesta."
    fi
  else
    echo "⚠️ python3 non disponibile, salto la preparazione di VKD3D."
  fi

  echo "⬇️ Preparing DXVK-NVAPI component for Bottles..."
  mkdir -p "$BOTTLES_DATA_DIR/nvapi"

  if command -v python3 >/dev/null 2>&1; then
    if DXVK_NVAPI_URL=$(curl -sf https://api.github.com/repos/bottlesdevs/components/releases | python3 -c 'import json, sys
data = json.load(sys.stdin)
for release in data:
    for asset in release.get("assets", []):
        name = asset.get("name", "")
        if name.startswith("dxvk-nvapi") and name.endswith(".tar.gz"):
            print(asset["browser_download_url"])
            raise SystemExit
sys.exit(1)' 2>/dev/null); then
      TMP_NVAPI_DIR=$(mktemp -d)
      if curl -L --fail -o "$TMP_NVAPI_DIR/dxvk-nvapi.tar.gz" "$DXVK_NVAPI_URL"; then
        if tar -C "$TMP_NVAPI_DIR" -xzf "$TMP_NVAPI_DIR/dxvk-nvapi.tar.gz"; then
          EXTRACTED_NVAPI_DIR=$(find "$TMP_NVAPI_DIR" -mindepth 1 -maxdepth 1 -type d -print -quit)
          if [ -n "$EXTRACTED_NVAPI_DIR" ]; then
            DXVK_NVAPI_PACK_NAME=$(basename "$EXTRACTED_NVAPI_DIR")
            DEST_NVAPI_DIR="$BOTTLES_DATA_DIR/nvapi/$DXVK_NVAPI_PACK_NAME"
            rm -rf "$DEST_NVAPI_DIR"
            mv "$EXTRACTED_NVAPI_DIR" "$BOTTLES_DATA_DIR/nvapi/" && echo "✅ DXVK-NVAPI pronto: $DXVK_NVAPI_PACK_NAME"

            if [ -d "$BOTTLES_DATA_DIR/bottles" ]; then
              for bottle_path in "$BOTTLES_DATA_DIR"/bottles/*; do
                [ -d "$bottle_path" ] || continue
                bottle_name=$(basename "$bottle_path")
                echo "🔧 Aggiorno la bottle \"$bottle_name\" con DXVK-NVAPI..."
                flatpak run --command=bottles-cli "$APP_ID" edit -b "$bottle_name" --nvapi "$DXVK_NVAPI_PACK_NAME" || echo "⚠️ Impossibile aggiornare la bottle \"$bottle_name\" con DXVK-NVAPI"
              done
            fi
          else
            echo "⚠️ Estratto DXVK-NVAPI ma non trovo la directory risultante, passo oltre."
          fi
        else
          echo "⚠️ Impossibile estrarre l'archivio DXVK-NVAPI."
        fi
      else
        echo "⚠️ Download del componente DXVK-NVAPI non riuscito."
      fi
      rm -rf "$TMP_NVAPI_DIR"
    else
      echo "⚠️ Nessun asset DXVK-NVAPI trovato sull'API di Bottles, installazione manuale richiesta."
    fi
  else
    echo "⚠️ python3 non disponibile, salto la preparazione di DXVK-NVAPI."
  fi

  echo "📦 Creating Also a Bottles Offline Mode Launcher..."
  LAUNCHER_NAME="Bottles (Offline)"
  DESKTOP_FILE="$HOME/.local/share/applications/${APP_ID}-offline.desktop"

  if ! flatpak info "$APP_ID" >/dev/null 2>&1; then
    echo "AVVISO: l'app $APP_ID non risulta installata con Flatpak."
  fi

  mkdir -p "$(dirname "$DESKTOP_FILE")"

  cat > "$DESKTOP_FILE" <<EOF
  [Desktop Entry]
  Version=1.0
  Type=Application
  Name=${LAUNCHER_NAME}
  Comment=Avvia Bottles in modalità offline (senza rete) e mostra il terminale
  Exec=flatpak run --unshare=network ${APP_ID}
  Icon=${APP_ID}
  Terminal=true
  TryExec=flatpak
  Categories=Utility;
  StartupNotify=true
EOF

  chmod 644 "$DESKTOP_FILE"

  # Aggiorna il database dei lanciatori (se disponibile)
  if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "\$HOME/.local/share/applications" || true
  fi

  echo "Creato: $DESKTOP_FILE"
  echo "Troverai la voce di menu come: ${LAUNCHER_NAME}"

fi

# Xpad installation
if is_selected "xpad"; then
  echo "📦 Installing xpad (Sticky Notes)..."
  sudo apt install -y xpad 
  sudo apt --fix-broken install -y
fi

# Waydroid installation
if is_selected "waydroid"; then
  echo "📦 Installing Waydroid..."
  curl -s https://repo.waydro.id | sudo bash -s trixie
  sudo apt update
  sudo apt install -y waydroid
  sudo apt --fix-broken install -y
fi

# Final message
echo ""
echo "✅ Done! Debian has been pimped based on your selection. Enjoy!"
