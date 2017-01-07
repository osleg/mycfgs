# Path to your oh-my-zsh installation.
export ZSH=/home/alex/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="half-life"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fbterm systemd heroku celery sudo archlinux extract\
        git-extras gitignore pip python tmux tmuxinator grunt\
        npm jsontools virtualenvwrapper golang common-aliases\
        taskwarrior fancy-ctrl-z)
#fbterm
# User configuration


# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias em='emacs -nw'
alias less='/usr/share/vim/vim74/macros/less.sh'
alias cls="echo -ne '\033c'"
alias mnt=mount_sdb4.sh
alias mux=tmuxinator
alias vimrc='vim ~/.vimrc'
alias zshrc='vim ~/.zshrc'
alias awrc='vim ~/.config/awesome/rc.lua'
alias -s pdf=zathura
alias W=watch
alias chkexternal='ls /run/media/alex/'
alias vim='nvim'
alias wimi='sudo wifi-menu'

unalias cp
unalias rm
unalias mv


export PATH="/home/alex/google-cloud-sdk/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/opt/android-sdk/platform-tools:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/alex/.gem/ruby/2.3.0/bin:/home/alex/node_modules/.bin:/home/alex/.bin"
export LANG=en_US.UTF-8
# GO lang exports
export GOPATH=~/go
export PATH="$PATH:$GOPATH/bin"

export EDITOR=vim
export=_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd' 
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export BROWSER="firefox"
#export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
    #vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    #-c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    #-c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

[ -n "$FBTERM" ] && export TERM=fbterm

PATH="/home/alex/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/alex/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/alex/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/alex/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/alex/perl5"; export PERL_MM_OPT;


