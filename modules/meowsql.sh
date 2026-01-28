#!/bin/bash

install_meowsql() {
  echo "⬇️ Downloading MeowSQL AppImage..."
  wget -O MeowSQL.AppImage https://github.com/ragnar-lodbrok/meow-sql/releases/download/v0.4.18-alpha/Linux_MeowSQL_0.4.18-x86_64.AppImage

  echo "📦 Installing MeowSQL to /opt..."
  sudo mv MeowSQL.AppImage /opt/MeowSQL.AppImage
  sudo chmod +x /opt/MeowSQL.AppImage

  echo "🖥️ Creating menu entry for MeowSQL..."
  cat <<EOF_DESKTOP | sudo tee /usr/share/applications/meowsql.desktop > /dev/null
[Desktop Entry]
Name=MeowSQL
Comment=Database client similar to DBeaver
Exec=/opt/MeowSQL.AppImage
Icon=utilities-terminal
Terminal=false
Type=Application
Categories=Development;Database;
EOF_DESKTOP
}
