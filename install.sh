#!/usr/bin/env bash

# set -euo se detiene ante errores
set -euo pipefail

# calculamos donde esta dotfiles
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# calculamos donde ira el backup
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# 1. paquetes oficiales

if [[ "${SKIP_PKGS:-0}" != "1" ]]; then
	echo "==> Instalando paquetes de pacman.txt"
	sudo pacman -S --needed - < "$DOTFILES/packages/pacman.txt"
fi

# 2. Copiar configuraciones
while IFS= read -r path; do
	[[ -z "$path" || "$path" == \#* ]] && continue

	src="$DOTFILES/home/$path"
	dst="$HOME/$path"

	if [[ -e "$src" ]]; then
		if [[ -e "$dst" || -L "$dst" ]]; then
			# si ya existe algo en el destino, lo movemos al backup
			mkdir -p "$BACKUP/$(dirname "$path")"
			mv "$dst" "$BACKUP/$path"
		fi

		mkdir -p "$(dirname "$dst")"
		rsync -a "$src" "$(dirname "$dst")/"
		echo "✔ $path"
	else
		echo "⚠ no está en el repo: $path"
	fi
done < "$DOTFILES/files.txt"

echo "Listo. Backup en: $BACKUP"
	

