#!/bin/bash

install_bottles() {
  echo "📦 Installing Flatpak and Bottles..."
  sudo apt install -y flatpak
  sudo apt --fix-broken install -y
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  sudo flatpak install -y flathub com.usebottles.bottles

  common_graphics_pkgs=(libvkd3d1 libvkd3d-shader1 vulkan-tools)
  sudo apt install -y "${common_graphics_pkgs[@]}"

  audio_video_pkgs=(libvulkan1 libvulkan1:i386 libasound2 libasound2:i386 gstreamer1.0-plugins-base gstreamer1.0-plugins-base:i386 gstreamer1.0-plugins-good gstreamer1.0-plugins-good:i386)
  sudo apt install -y "${audio_video_pkgs[@]}"

  if [ "$GPU_VENDOR" = "nvidia" ]; then
    echo "🔎 Rilevata GPU NVIDIA: salto i pacchetti Mesa che forzerebbero la rimozione dei driver proprietari."
    if apt-cache show nvidia-driver-libs:i386 >/dev/null 2>&1; then
      sudo apt install -y nvidia-driver-libs:i386 || echo "⚠️ Impossibile installare automaticamente nvidia-driver-libs:i386. Controlla la configurazione dei repository non-free."
    else
      echo "ℹ️ Il pacchetto nvidia-driver-libs:i386 non è disponibile nei repository configurati."
    fi
    sudo flatpak install -y flathub org.freedesktop.Platform.GL.nvidia-580-95-05 || echo "⚠️ Impossibile installare il runtime Flatpak org.freedesktop.Platform.GL.nvidia-580-95-05."
  else
    mesa_pkgs=(mesa-vulkan-drivers mesa-vulkan-drivers:i386 libgl1-mesa-dri libgl1-mesa-dri:i386)
    sudo apt install -y "${mesa_pkgs[@]}"
  fi
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

  cat > "$DESKTOP_FILE" <<EOF_DESKTOP
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
EOF_DESKTOP

  chmod 644 "$DESKTOP_FILE"

  if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database "\$HOME/.local/share/applications" || true
  fi

  echo "Creato: $DESKTOP_FILE"
  echo "Troverai la voce di menu come: ${LAUNCHER_NAME}"
}
