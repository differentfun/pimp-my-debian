#!/bin/bash

install_samba_autofix() {
  log_info "📦 Installing Samba + GVFS backends..."
  sudo apt-get install -y samba gvfs-backends gvfs-fuse smbclient kiofuse kio-extras

  log_info "🛠️  Forcing SMB2/SMB3 client protocol compatibility..."
  sudo bash -c 'python3 - <<'"'"'PY'"'"'
from pathlib import Path
path = Path("/etc/samba/smb.conf")
text = path.read_text()
lines = text.splitlines()
min_line = "   client min protocol = SMB2"
max_line = "   client max protocol = SMB3"
try:
    gidx = next(i for i, l in enumerate(lines) if l.strip().lower() == "[global]")
except StopIteration:
    raise SystemExit("[global] not found in smb.conf")
end = next((i for i in range(gidx + 1, len(lines)) if lines[i].strip().startswith("[")), len(lines))
section = lines[gidx + 1:end]
section = [l for l in section if not l.strip().lower().startswith("client min protocol") and not l.strip().lower().startswith("client max protocol")]
insert_at = 0
for i, l in enumerate(section):
    if l.strip().lower().startswith("workgroup"):
        insert_at = i + 1
        break
section[insert_at:insert_at] = [min_line, max_line]
new_lines = lines[:gidx + 1] + section + lines[end:]
path.write_text("\n".join(new_lines) + "\n")
PY'

  log_info "🔄 Restarting GVFS services..."
  systemctl --user restart gvfs-daemon.service gvfs-metadata.service gvfs-udisks2-volume-monitor.service gvfs-gphoto2-volume-monitor.service gvfs-mtp-volume-monitor.service gvfs-afc-volume-monitor.service 2>/dev/null || true

  log_info "🧩 Ensuring Thunar shows Network in sidebar..."
  mkdir -p "$HOME/.config/gtk-3.0"
  if [ -f "$HOME/.config/gtk-3.0/bookmarks" ]; then
    printf '%s\n' "network:///" | cat - "$HOME/.config/gtk-3.0/bookmarks" | awk '!seen[$0]++' > "$HOME/.config/gtk-3.0/bookmarks.new"
    mv "$HOME/.config/gtk-3.0/bookmarks.new" "$HOME/.config/gtk-3.0/bookmarks"
  else
    printf '%s\n' "network:///" > "$HOME/.config/gtk-3.0/bookmarks"
  fi
}
