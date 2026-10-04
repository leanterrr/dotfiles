eval "$(starship init zsh)"

# Monochrome eza
export EZA_COLORS="uu=bright-black:gu=bright-black:da=bright-black:ur=white:uw=bright-black:ux=white:ue=bright-black:gr=bright-black:gw=bright-black:gx=white:tr=bright-black:fi=white:di=bright-white:ln=bright-black:pi=bright-black:so=bright-black:bd=bright-black:cd=bright-black:or=bright-black:mi=bright-black:ex=white"

alias ls='eza --icons=always'
alias ll='eza -lah --icons=always --git'
alias la='eza -a --icons=always'
alias lt='eza --tree --icons=always'
alias llt='eza -lah --sort=modified --icons=always --git'


# --------------------------------------------------
# Completion
# --------------------------------------------------

autoload -Uz compinit
compinit

# Better completion menu
zstyle ':completion:*' menu select

# Case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Completion colors — grayscale
zstyle ':completion:*' list-colors \
  '=(#b)*(=0)=38;5;250' \
  '=(#b)*(=1)=38;5;255' \
  '=(#b)*(=2)=38;5;245' \
  '=(#b)*(=3)=38;5;240'

# Autosuggestions — dark gray
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --------------------------------------------------
# Keybindings (Vim mode & Custom)
# --------------------------------------------------

# Activar modo Vim
bindkey -v

# Arreglar el comportamiento de la tecla retroceso en modo inserción
bindkey '^?' backward-delete-char

# Autocompletar sugerencias con Ctrl + F (en modo inserción)
bindkey -M viins '^f' autosuggest-accept

# Restaurar la búsqueda del historial con Ctrl + R
bindkey -M viins '^r' history-incremental-search-backward

# Función para limpiar y mostrar fastfetch
function clear_and_fetch() {
    clear
    fastfetch
    echo ""
    zle reset-prompt
}

# Convertir la función en un widget de Zsh
zle -N clear_and_fetch

# Atar Ctrl + L al nuevo widget en modo inserción y comando
bindkey '^L' clear_and_fetch
bindkey -M viins '^L' clear_and_fetch


# Grayscale
ZSH_HIGHLIGHT_STYLES[command]='fg=white'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=white'
ZSH_HIGHLIGHT_STYLES[function]='fg=white'
ZSH_HIGHLIGHT_STYLES[alias]='fg=white'
ZSH_HIGHLIGHT_STYLES[path]='fg=245'
ZSH_HIGHLIGHT_STYLES[comment]='fg=240'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=245'


fastfetch
