#!/bin/bash

install_openshot() {
  echo "⬇️ Downloading OpenShot AppImage..."
  wget -O OpenShot.AppImage https://github.com/OpenShot/openshot-qt/releases/download/daily/OpenShot-v3.4.0-release-candidate-14124-6cea273b-0b018e34-x86_64.AppImage

  echo "📦 Installing OpenShot to /opt..."
  sudo mv OpenShot.AppImage /opt/OpenShot.AppImage
  sudo chmod +x /opt/OpenShot.AppImage

  echo "🖥️ Creating menu entry for OpenShot..."
  cat <<EOF_DESKTOP | sudo tee /usr/share/applications/openshot.desktop > /dev/null
[Desktop Entry]
Name=OpenShot Video Editor
Comment=Simple and powerful video editor
Exec=/opt/OpenShot.AppImage
Icon=video-x-generic
Terminal=false
Type=Application
Categories=AudioVideo;Video;Editing;
EOF_DESKTOP
}
