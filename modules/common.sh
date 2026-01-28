#!/bin/bash

# Shared helpers for installers.

log_info() {
  echo "$@"
}

log_warn() {
  echo "$@"
}

apt_fix() {
  sudo apt --fix-broken install -y
}

apt_install() {
  sudo apt install -y "$@"
  apt_fix
}

install_apt_app() {
  local label="$1"
  shift
  log_info "📦 Installing ${label}..."
  apt_install "$@"
}

is_selected() {
  [[ " ${SOFTWARE[@]} " =~ " $1 " ]]
}

detect_gpu_vendor() {
  if command -v nvidia-smi >/dev/null 2>&1; then
    echo "nvidia"
    return
  fi

  if command -v lspci >/dev/null 2>&1; then
    if lspci | grep -qi 'nvidia'; then
      echo "nvidia"
      return
    elif lspci | grep -qi 'advanced micro devices\|amd'; then
      echo "amd"
      return
    elif lspci | grep -qi 'intel'; then
      echo "intel"
      return
    fi
  fi

  echo "unknown"
}

ensure_zenity() {
  if ! command -v zenity >/dev/null 2>&1; then
    log_info "📦 Installing Zenity..."
    apt_install zenity
  fi
}
