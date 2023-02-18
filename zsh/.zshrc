# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

HISTSIZE=5000
SAVEHIST=5000

POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'no'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'pc'

# Start tmux if not already in tmux.
#zstyle ':z4h:' start-tmux command tmux -u new -A -D -t z4h

# Whether to move prompt to the bottom when zsh starts and on Ctrl+L.
zstyle ':z4h:' prompt-at-bottom 'no'

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'no'

# Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv'         enable 'no'
# Show "loading" and "unloading" notifications from direnv.
zstyle ':z4h:direnv:success' notify 'yes'

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# SSH when connecting to these hosts.
zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*'                   enable 'no'

# Send these files over to the remote host when connecting over SSH to the
# enabled hosts.
zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
#z4h install ohmyzsh/ohmyzsh || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Extend PATH.
path=(~/bin $path)

# Export environment variables.
export GPG_TTY=$TTY

# Source additional local files if they exist.
z4h source ~/.env.zsh

# Use additional Git repositories pulled in with `z4h install`.
#
# This is just an example that you should delete. It does nothing useful.
#z4h source ohmyzsh/ohmyzsh/lib/diagnostics.zsh  # source an individual file
#z4h load   ohmyzsh/ohmyzsh/plugins/emoji-clock  # load a plugin

# Define key bindings.
z4h bindkey z4h-backward-kill-word  Ctrl+Backspace     Ctrl+H
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace

z4h bindkey undo Ctrl+/ Shift+Tab  # undo the last command line change
z4h bindkey redo Alt+/             # redo the last undone command line change

z4h bindkey z4h-cd-back    Alt+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Alt+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Alt+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Alt+Down   # cd into a child directory

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Define aliases.
alias tree='tree -a -I .git'

# Add flags to existing aliases.
#alias ls="${aliases[ls]:-ls} -A"

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu



# USER CONFGIURATION

#SETTINGS
#set -o vi
setopt extended_glob
#ENV VARS AND ALIASING

export PATH="$HOME/.local/bin:$HOME/.cargo/env:$PATH"

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export WALLPAPER=$HOME/.config/awesome/default/wallpapers/gopniks_squating.jpg
#export ZDOTDIR = $HOME/.config/zsh


alias history='cat ~/.zsh_history | rg'
alias ls='lsd --color always'
alias lsa='lsd -a'
alias la='lsd -la'
alias resa="echo 'awesome.restart()' | awesome-client"
alias feh='feh -.Z'
alias dots='cd ~/dotfiles'
alias sudo='doas'

#Add 80's(https://www.youtube.com/watch?v=djV11Xbc914&list=PLCD0445C57F2B7F41), Stake, 2000s, Powerwolf(https://www.youtube.com/watch?v=4hshdNgEwTw&list=PLTqLptwSqnw6rW-Pa-5L7ryvcGjMe_rMk)
DJB="https://youtube.com/playlist?list=PLzj5GT2RkVUw1BuTWya6oPNlEGe2y8IYO"
HB="https://www.youtube.com/playlist?list=PLcRf8jmIXme3EmidIIywmYSVliqoSy-4g"
HB2="https://www.youtube.com/watch?v=QiFBgtgUtfw&list=PLaSEGJ7Uk6tNv6x0vUSrVUOKrMclJphgk"
HB3="https://www.youtube.com/watch?v=yL4eIUTovLM&list=PLr8OFJdMNnyK6P3KFgcapuA9jbLe0ezUj"
HB4="https://www.youtube.com/watch?v=fro6je9L5kg&list=PLKC_G6D4dEWsKEnxurb02lnWF5lDpgvbQ"
HBS="https://www.youtube.com/playlist?list=PL9WjPaLKxYbg5_gYsT0cXsGuzJLdWKHMO"
HBSC="https://www.youtube.com/playlist?list=OLAK5uy_kXwwqc69fOkbzgupAyYH8fHRQbVokhAbs"

alias playlist='mpv --shuffle --ytdl-raw-options="cookies=${cookies_file}"'

# Have be able to record combinations of desktop audio, mic audio, desktop, and webcam
RES=`xrandr | awk -F'[ +]' '/primary/{print $4}'`
alias screenshot='echo "screenshot in 3 seconds" && sleep 3 && ffmpeg -loglevel quiet -f x11grab -framerate 1 -video_size $RES -i :0.0 -vframes 1 ' #output.jpeg(must specify output file)
alias screenrecord='ffmpeg -f x11grab -s $RES -i :0.0' # (must specify output file) f: format, not everything is a file, record screen, x11grab: take whatever is on screen as input, s: screensize i: input file :0.0 is the default screen out.mkv: the file output
#alias screencast='ffmpeg -f x11grab -s $RES -i :0.0 -f alsa -i default' # (must specify output file) f: format, not everything is a file, record screen, x11grab: take whatever is on screen as input, s: screensize i: input file :0.0 is the default screen out.mkv: the file output
#alias screencast='ffmpeg -f x11grab -s $RES -i :0.0 -f alsa -ac 2 -i hw:0 -use_wallclock_as_timestamps 1' # (must specify output file) f: format, not everything is a file, record screen, x11grab: take whatever is on screen as input, s: screensize i: input file :0.0 is the default screen out.mkv: the file output
# f alsa -ac 2 -i hw:0
alias record='ffmpeg -i /dev/video0 ' #record with webcam, must specify output file

#ffmpeg -f x11grab -framerate 1 -video_size 1600x900 -i :0.0 -vframes 1 output2.jpeg

#alias mpv='mpv --no-keepaspect-window'
#alias clear='tput -x clear'
#bind -x '"\C-l": clear; pfetch; ls'


#services/startup
echo 
clear
nitch
#pfetch
#neofetch
#lsa
