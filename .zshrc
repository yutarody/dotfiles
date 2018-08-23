# load zgen
source "$HOME/.zgen/zgen.zsh"

# local bins
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# for coreutils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# for gnu-tar
export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"

# for homebrew-cask
export HOMEBREW_CASK_OPTS="--audio_unit_plugindir=/Library/Audio/Plug-Ins/Components --vst_plugindir=/Library/Audio/Plug-Ins/VST"

# for pyenv
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#  for rbenv
export PYENV_ROOT="$HOME/.pyenv"
eval "$(rbenv init -)"

# Brewfile オリジナルのbrewコマンドを使った後に 自動でBrewfileをアップデートするようにする
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

# function
function pecd {
    local dir="$( find . -maxdepth 1 -type d | sed -e 's;\./;;' | peco )"
    if [ ! -z "$dir" ] ; then
        cd "$dir"
    fi
}

# ailas
alias top='top -u'
alias brew-upgrade-list='for c in `brew cask list`; do ! brew cask info $c | grep -qF "Not installed" || echo $c; done'
alias generate-cask-token='$(brew --repository)/Library/Taps/caskroom/homebrew-cask/developer/bin/generate_cask_token'
alias relogin='exec $SHELL -l'

# if the init scipt doesn't exist
if ! zgen saved; then

  # zgen prezto
  zgen prezto
  zgen prezto prompt theme 'cloud'
  zgen prezto gnu-utility
  zgen prezto git
  zgen prezto osx
  zgen prezto rsync
  zgen prezto homebrew

  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-history-substring-search
  zgen load zsh-users/zsh-completions src
  zgen load chrissicool/zsh-256color
  # Automatically run zgen update and zgen selfupdate every 7 days
  zgen load unixorn/autoupdate-zgen
  # macOS-specific functions https://github.com/unixorn/tumult.plugin.zsh
  zgen load unixorn/tumult.plugin.zsh
  # etc. Alias tip: ll
  zgen load djui/alias-tips

  # k is a zsh script / plugin to make directory listings more readable,
  # adding a bit of color and some git status information on files and directories
  zgen load rimraf/k

  # generate the init script from plugins above
  zgen save
fi
