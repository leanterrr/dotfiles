#!/usr/bin/env bash


set -euo pipefail
# -e se detiene si un comando falla
# -u se detiene si se usa una variable que no existe
# -o pipefail si falla un comando dentro de una tuberia, cuenta como fallo

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Creamos DOTFILES para que el script funcione igual lo ejecutes donde lo ejecutes, siempre sabe donde esta su carpeta
# BASH_SOURCE[0] es la ruta del propio script, dirname se queda con la carpeta que lo contiene
# cd "..." && pwd entra en ella y escribe su ruta completa

# Hacemos bucle que lea files.txt ( lo indicamos tras el done, es como un do-while, para que cuando no hay mas filas en files.txt, termine
# cada linea de files.txt lo llamamos $path
while IFS= read -r path; do
  [[ -z "$path" || "$path" == \#* ]] && continue

  src="$HOME/$path"
  dst="$DOTFILES/home/$path"

  if [[ -e "$src" ]]; then
    mkdir -p "$(dirname "$dst")"
    # Sincronizamos la carpeta o fichero en dotfiles con el fichero real, a diferencia de cp, rsync solo copia lo diferente o nuevo, y podemos indicar con --delete que borre del destino lo que ya no existe en el origen.
    # Los \ le indican a bash que el comando continua en la linea siguiente, sin el, se ejecutaria primero una y despues otra (solo funciona si es el ultimo caracter de la linea)
    rsync -a --delete \
	--exclude='cache/' --exclude='.cache/' --exclude='*.log' --exclude='*.bak' \
      "$src" "$(dirname "$dst")/"
    echo "✔ $path"
  else
    echo "⚠ no existe: $path"
  fi
done < "$DOTFILES/files.txt"

# Listas de paquetes en ficheros .txt para que se instalen en un install.sh
# pacman -Qqen > "$DOTFILES/packages/pacman.txt" # paquetes instalados con pacman
# pacman -Qqem > "$DOTFILES/packages/aur.txt" # paquetes instalados con yay
# los pacman -Qqem no los usamos ya que hemos modificado pacman.txt y aur.txt a mano
echo "✔ listas de paquetes actualizadas"
