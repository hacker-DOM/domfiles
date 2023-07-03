# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# = ZSH {{{1
export EDITOR="nvim"

# sn() {
# export NVM_DIR="$HOME/.nvm"
# # This loads nvm
# [ -s "$NVM_DIR/nvm.sh" ] \
# 	&& \. "$NVM_DIR/nvm.sh" &> /dev/null
# # This loads nvm bash_completion
# [ -s "$NVM_DIR/bash_completion" ] \
# 	&& \. "$NVM_DIR/bash_completion"  &> /dev/null
# }
export PATH="/opt/homebrew/bin:$PATH"
#export PATH="/opt/homebrew/
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
fpath+=("/opt/homebrew/share/zsh/site-functions")
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
bindkey " " magic-space

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history

# NVIM_C="exe \"normal M \| SplitAndScrollBind\""
# alias ez="nvim -c '$NVIM_C' $HOME/.zshrc"

foo()
{
	fc -ln | nvim -c 'normal G'
}

DOM_CLW_VIM='
normal! G
function FnSelectLineSaveAndQuit()
	1,.-1d
	.+1,$d
	wqa
endfunction
noremap <CR> :call FnSelectLineSaveAndQuit()<CR>
inoremap <CR> <ESC>:call FnSelectLineSaveAndQuit()<CR>
'

alias p="cdn ~/p"

function clw()
{
    echo "$DOM_CLW_VIM" > /tmp/clw.vim
    _EDITOR="$EDITOR"
    EDITOR="nvim -S /tmp/clw.vim --"
    fc -ln -100000 | vipe | read res
    LBUFFER=$res
    RBUFFER=""
    EDITOR="$_EDITOR"
}

zle -N clw
bindkey -v
bindkey -v ^Z clw

HOSTNAME=`hostname`
if [[ $HOSTNAME == Dominiks-Air* ]]
then
	PC="Air"
	#if [ ! -z "$PS1" ]
	#then
	#	echo 'Welcome to Dominiks-Air!'
	#fi
	PATH=$PATH:/opt/homebrew/bin
elif [[ $HOSTNAME == DominiksMBP2019* ]]
then
	PC="MBP"
	#if [ ! -z "$PS1" ]
	#then
	#	echo 'Welcome to DominiksMBP!'
	#fi
	# PATH=$PATH:/usr/local/Homebrew/bin
fi

# echo $PC
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# sv()
# {
    export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
    export WORKON_HOME=$HOME/.virtualenvs
    pyenv virtualenvwrapper_lazy

# }
# = OH-MY-ZSH {{{1
export ZSH=/Users/dteiml/.oh-my-zsh

export NVM_LAZY_LOAD=true

plugins=(
    pip
    zsh-nvm
    # shell completion for pdm
    # see https://pdm.fming.dev/latest/#shell-completion
    pdm
    zsh-autosuggestions
    zsh-syntax-highlighting
    you-should-use
    zsh-vi-mode
    history-substring-search
    bd
    zsh-z
    # zsh-interactive-cd
    thefuck
    zhooks
    zsh-sccd
    # zsh-system-clipboard # not using this, just redefined `zvm-vi-yank`
)

source $ZSH/oh-my-zsh.sh

bindkey -v
bindkey -v "^[[1;3D" backward-word
bindkey -v "^[[1;3C" forward-word
bindkey -v "^[[1;9D" beginning-of-line
bindkey -v "^[[1;9C" end-of-line
bindkey -v '\x1b\x7f' backward-kill-word
# doesn't work
bindkey -v '\x7f'    backward-kill-line
# bindkey -v "^[[3;3$HOME" kill-word
# bindkey -v "^[[3;9$HOME" kill-line
autoload edit-command-line
zle -N edit-command-line
bindkey -M vicmd ' ' edit-command-line


cdn()
{
    cd "$1" > /dev/null
}
# = CONFIG-FILES {{{1
# NVIM_C="exe \"normal M \| SplitAndScrollBind\""
# alias ez="nvim -c '$NVIM_C' $HOME/.zshrc"
NVIM_C="exe \"normal M \| SplitAndScrollBind\""
# alias ez="nvim $HOME/.zshrc -c 'normal M' -c 'SplitAndScrollBind'"
#DOM_BEGIN_ALMOST_AT_END="+ -c 'norm! 10k' -c 'feedkeys(\'zz\', \'n\')"
DOM_BEGIN_ALMOST_AT_END="+ -c 'norm! 10k' -c 'call feedkeys(\"zz\", \"n\")'"
alias eze="nvim $DOM_BEGIN_ALMOST_AT_END $HOME/.zshenv" 
alias  ez="nvim $DOM_BEGIN_ALMOST_AT_END $HOME/.zshrc" 
alias  el="nvim $DOM_BEGIN_ALMOST_AT_END $HOME/.lesskey" 
alias elg="nvim $DOM_BEGIN_ALMOST_AT_END $HOME'/Library/Application Support/lazygit/config.yml'" 
alias  ek="cdn $HOME/.config/kitty; nvim $DOM_BEGIN_ALMOST_AT_END kitty.conf"
alias eka="cdn $HOME/.config/karabiner; nvim $DOM_BEGIN_ALMOST_AT_END karabiner.edn"
alias  er="cdn $HOME/.config/ranger; nvim $DOM_BEGIN_ALMOST_AT_END rc.conf" 
alias  em="nvim $DOM_BEGIN_ALMOST_AT_END $HOME/.mackup.cfg"
alias  eh="cdn $HOME/.hammerspoon; nvim $DOM_BEGIN_ALMOST_AT_END init.lua"
alias  eg="nvim $DOM_BEGIN_ALMOST_AT_END $HOME/.gitconfig"
alias egi="nvim $DOM_BEGIN_ALMOST_AT_END $HOME/.gitignore"
# alias  en="cdn $HOME/.config/nvim; nvim $DOM_BEGIN_ALMOST_AT_END init.lua"
alias  en="cdn $HOME/.config/nvim; nvim lua/plugins/dom.lua"
dom_nt()
{
  cdn $HOME/Dropbox/notes/neorg; nvim $(ls **/*.norg | head -n 5)
}
alias nt=dom_nt
alias  ev="cdn $HOME/.config/nvim; nvim $DOM_BEGIN_ALMOST_AT_END dom.vim"
alias eip="cdn $HOME/.ipython; nvim $DOM_BEGIN_ALMOST_AT_END profile_default/ipython_config.py"
alias epy="nvim $DOM_BEGIN_ALMOST_AT_END $HOME/.config/python/startup.py"

alias sze="source $HOME/.zshenv"
alias  sz="source $HOME/.zshrc"

# == tmux config {{{1
alias et="cdn $HOME; nvim $DOM_BEGIN_ALMOST_AT_END .tmux.conf"
alias st="tmux source-file $HOME/.tmux.conf"

# = ALIAS-OTHER {{{1
alias ip="ipython"
alias py="python3"
alias f="dom_lsd && pwd"
alias v="pbpaste"
#https://github.com/sharkdp/bat/issues/1050#issuecomment-638593463
alias cat="bat"

# = OTHER {{{1
alias in="cd"
#alias -g p="$HOME/p"
#alias -g ,h="--help | nvim -c 'normal M'"
alias th="trash build artifacts cache typechain crytic-export"
alias switch-remotes="python3 /Users/dteiml/p/scratch/21-q4/switch-remotes/main.py"
export EDITOR="nvim"

# = GIT {{{1
alias g="git"

alias gf="git fetch"

alias gp="git pull"

alias gpu="git push origin HEAD"

alias gl="git log"

alias gls="git log --pretty=oneline"

alias gll="git log --stat"

alias ga="git add"

alias gr="git remote -v"

alias gst="git stash"

alias gs="git status -sb && git log --oneline -n 5"

alias gb="git branch -av"

alias gmu="git submodule update --init --recursive"

# alias gc="dom_git_clone"


# dom_git_clone()
# {
#     echo "$@"
#     gh repo clone "$@"
#     idea:cd into repo dir
#     impl:find arg that contains "git"
#     dir=$(echo $$ 
#     dir=$(echo "$@" | python3 -c 'args=input(); args=args.split(" "); args=list(filter(lambda s: "/" in s, args)); print(args[0].split("/")[-1])')
#     if [[ -d "$dir" ]]
#     then
#             echo "cding into $dir"
#             cd "$dir"
#     fi
# }

function dom_get_cd_dir {
    if [[ $# -ge 2 ]]; then
        echo "$2"
    elif [[ $# = 1 ]]; then
        echo $(basename "$@[-1]" .git)
    fi
}    

function gtg {
    local dir=$(basename $(pwd) -sl)
    cd "../$dir-git"
}

function gts {
    local dir=$(basename $(pwd) -git)
    cd "../$dir-sl"
}

function dom_gh_cd {
    local dir=$(dom_get_cd_dir "$@")
    if [[ -n "$dir" ]]; then
        cd "$dir"
    fi
}

function dom_gh_clone {
    # remove leading or tralinig slashes
    local first_arg=$(sd '^/?(.*?)/?$' '$1' <<< "$1")
    shift
    # echo $first_arg
    # echo $@
    gh repo clone "$first_arg" "$@" -- --recursive
    dom_gh_cd "$first_arg" "$@"
}

alias gc="dom_gh_clone"

function dom_gh_clone_branch {
    gh repo clone "$@" -- --single-branch --recursive
    dom_gh_cd "$@"
}

alias gcb="dom_gh_clone_branch"

function dom_gh_clone_depth {
    gh repo clone "$@" -- --depth 1 --recursive
    dom_gh_cd "$@"
}

alias gcd="dom_gh_clone_depth"

function dom_gh_clone_branch_depth {
    gh repo clone "$@" -- --single-branch --depth 1 --recursive
    dom_gh_cd "$@"
}

function dom_sl_clone {
    sl clone --git "$@"
    dom_gh_cd "$@"
}

function dom_slg_clone {
    local dir=$(dom_get_cd_dir "$@")
    gh repo clone "$@"  "$dir-git"
    sl clone --git "$@" "$dir-sl"
    
    dom_gh_cd placeholder "$dir-sl"
}

alias gcdb="dom_gh_clone_branch_depth"

alias gcbd="dom_gh_clone_branch_depth"

alias gch="git checkout"

alias gd="git difftool --no-symlinks --dir-diff"

alias gco="git commit"

alias gm="gitmoji -c && git push origin HEAD"

alias gg="git grep"

alias sc="dom_sl_clone"

alias scg=dom_slg_clone

# = NVIM {{{1

alias vi="nvim"

alias vim="nvim"

function dom_nvim() {
    # if called with arguments, dispatch no `nvim`
    # if called w/o arguments, if current directory contains a file "README*", open it
    if [[ $# -eq 0 ]]; then
	local readme=$(find . -maxdepth 1 -iname "README*" | head -n 1)
	if [[ -n "$readme" ]]; then
	    nvim "$readme" +'Neotree reveal float' "$@"
	else
	    nvim "$@"
	fi
    else
	nvim "$@"
    fi
}

alias e="dom_nvim"

# = TMUX {{{1

# alias t="tmux"

# BLA BLA BLA BLA BL
# lsd long
alias lsdl="command lsd -lA --group-dirs first --hyperlink never --color always"
# lsd short
alias lsds="command lsd -A --group-dirs first --hyperlink never --color always"

dom_lsd()
{
    if [[ $(tput cols) -le 78 ]]; then
	lsds
    else
	lsdl
    fi
}

dom_lsd_tree()
{
    if [[ $(tput cols) -le 78 ]]; then
	lts
    else
    	ltl
    fi
}

# = GENERIC HELPERS {{{1
lts() 
{
	if [ $# -eq 0 ]
	then
		local DEPTH=2
	else
		local DEPTH=$1
		shift
	fi
	lsds --tree --depth "$DEPTH" "$@"
}
ltl()
{
	if [ $# -eq 0 ]
	then
		local DEPTH=2
	else
		local DEPTH=$1
		shift
	fi
	lsdl --tree --depth "$DEPTH" "$@"
}
alias lt="dom_lsd_tree"
# dom_ltl()
# {
# 	lt "$@" | less
# }
# alias ltls="dom_ltls"
# dom_ltls()
# {
# 	lts "$@" | less
# }

# pipe stdin to echo -n to rm newline, then copy to clipboard
c()         { echo -n "$(\cat -)" | pbcopy }

# copy arg
ca()        { \cat "$1" | c }

cl()        { cloc $@ --by-file-by-lang }

mt()        { mkdir -p $(dirname $1); touch $1 }

me()        { mkdir -p $(dirname $1); "$EDITOR" $1 }

mce()       { mkdir -p $(dirname $1); cd $(dirname $1); "$EDITOR" $(basename $1) }

mc()        { mkdir -p $1 && in $1 }

size()
{
if [[ $# -eq 0 ]]
then du -hcs .
else du -hcs $1
fi
}

hash()      { shasum -a 256 $1 }

findbyport(){ lsof -P -iTCP:$1 -sTCP:LISTEN }

# diff()      { git diff --no-index $1 $2 }

function chex()
{
chmod +x "$1";
    "./$1"
}

# = HELPERS-SPECIALIZED {{{1
# = PATH {{{1
PATH+=":$HOME/Library/echidna"

# = CONFIG {{{1

# == python {{{1
export PYTHONBREAKPOINT='IPython.core.debugger.set_trace'
export PYTHONBREAKPOINT="pdbr.set_trace"

# == pdm {{{1
if command -v "pdm" 1> /dev/null
then
eval "$(pdm --pep582 zsh)"
fi

# = ECHO {{{1
if [ ! -z "$PS1" ]
then
	neofetch
	#echo ".zshrc executed"
fi

# = UNCATEGORIZED {{{1
# path()
# {
# _path=(${(s/:/)PATH})
# printf "%s\n" "$_path[@]"
# }
#

alias ppath="echo $PATH | sed \"s|:|\n|g\""

# [ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh


# eval "$(zoxide init zsh)"


ZSH_FZF_HISTORY_SEARCH_END_OF_LINE=1
bindkey -v $ZSH_FZF_HISTORY_SEARCH_BIND fzf_history_search
# echo $PATH
eval "$(direnv hook zsh)"
alias mv="mv -i"
alias cp="cp -i"
()
{
# --file doesn't work with --global
local FILE_MBP=".Brewfile-MBP"
local FILE_AIR=".Brewfile-Air"
alias bbp="brew bundle --global --force dump    && mv $HOME/.Brewfile $HOME/Dropbox/Mackup/$FILE_MBP    && ln -sf $HOME/Dropbox/Mackup/$FILE_MBP $HOME/$FILE_MBP"
alias bba="brew bundle --global --force dump    && mv $HOME/.Brewfile $HOME/Dropbox/Mackup/$FILE_AIR    && ln -sf $HOME/Dropbox/Mackup/$FILE_AIR $HOME/$FILE_AIR"
alias bbd="diff $HOME/$FILE_MBP $HOME/$FILE_AIR"
}
db-ignore()
{
xattr -w com.dropbox.ignored 1 "$1"
}

pyhelp()
{
if [ $# -eq 1 ]
then
	open "https://docs.python.org/3/library/$1.html"
elif [ $# -eq 2 ]
then
	open "https://docs.python.org/3/library/$1.html#$1.$2"
fi

}

export PATH="$PATH:/Users/dteiml/.foundry/bin"

ms()
{
    set -e
    day=$(date +%d)
    month=$(date +%m)
    year=$(date +%y)

    case "$month" in
        01|02|03) quarter=q1;;
        04|05|06) quarter=q2;;
        07|08|09) quarter=q3;;
        10|11|12) quarter=q4;;
        *) return;;
    esac
    cdn "$HOME/p/scratch/"
    if [ ! -d "$year-$quarter" ]
    then
        mkdir "$year-$quarter"
    fi
    if [ $# -eq 0 ]
    then
        cd "$year-$quarter"
    else
        cdn "$year-$quarter"
        directory="$month-$day-$1"
        if [ ! -d "$directory" ]
        then
                mkdir "$directory"
        fi
        cd "$directory"
    fi
    set +e
}


alias d="dirs -v"
setopt PUSHD_SILENT
function custom_chpwd() {
    if [[ -f ".nvmrc" ]]; then
	nvm use
    fi

    # if [[ -f ".python-version" ]]; then
    #     pyenv use
    # fi

    if [[ -d ".git" ]]; then
	onefetch
    fi

    f

    # handle_venv
}
add-zsh-hook chpwd custom_chpwd
# also run it on new shells

function handle_venv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # variable is set and non-empty
	# if [[ $(dirname "$VIRTUAL_ENV")* != "$PWD" ]] && [[ "$VIRTUAL_ENV" != "$PWD"* ]]; then
	if [[ "$PWD" != "$(dirname "$VIRTUAL_ENV")"* ]]; then
	    # PWD and VIRUTAL_ENV are not subsrings of each other
	    echo 'running `deactivate`'
	    deactivate
	fi
    fi

    # variable is not set or empty
    if [[ -z "$VIRTUAL_ENV" ]] && [[ -d ".venv" ]]; then
	echo 'running `source .venv/bin/activate`'
	source .venv/bin/activate
    fi

}

# . "$HOME/.cargo/env"
export PAGER="bat"

# = STARSHIP {{{1
if command -v "starship" 1> /dev/null
then
    eval "$(starship init zsh)"
fi

HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
source "$HB_CNF_HANDLER";
fi
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd '^[[A' history-substring-search-up
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd '^[[B' history-substring-search-down
bindkey -M vicmd 'j' history-substring-search-down
# bindkey "$terminfo[kcuu1]" history-substring-search-up
# bindkey "$terminfo[kcud1]" history-substring-search-down
alias icat="kitty +kitten icat"

rme()
{
	set -x
	# IFS="/" read -ra arr <<< "$1"
	saveIFS="$IFS"
	IFS=':'
	arr=(${1})
	IFS="$saveIFS"
	url="https://raw.githubusercontent.com/$arr[1]/$arr[2]master/README.md"
	echo $url
	curl $url | mdcat
	#reader $url | less
	#mdcat $url | less
}
countc()
{
	echo -n $(v) | wc -c | awk '{print $1}'
}
countm()
{
	echo -n $(v) | wc -m | awk '{print $1}'
}
alias home="$HOME/p"
#begin nnn
n ()
{
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The backslash allows one to alias n to nnn if desired without making an
    # infinitely recursive alias
    \nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
# end nnn
export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG="f:preview-tui"
alias rg="hg -L --hidden --smart-case"
export PYTHONSTARTUP="$HOME/.config/python/startup.py"
#https://github.com/sharkdp/bat/issues/1050#issuecomment-638593463
# export LESSOPEN="$HOME/bin/sync/less-preprocessor-bat.sh open \"%s\""
#
# export LESSCLOSE="$HOME/bin/sync/less-preprocessor-bat.sh close \"%s\" \"%s\""
#rawcontrol chars & smartcase
# line numbers (-N) can't be included bc then it messes up bat
# -j.5: https://superuser.com/a/257626/852686
# should also be same as in ~/.config/kitty/open-actions.conf
export LESS="-R -i -j.5"
alias hexdump="hexdump -C"

x=$(<<'EOF'
import sys

def say_hi():
  print('h')
say_hi()
EOF
)

x='
import sys

def say_hi():
  print("\"hi\"")
say_hi()
'

domtest()
{

	python3 -c "$x"
}
alias i="f"
alias q="qalc"
alias h="help"
DOM_RUN_CMD=$(<<'EOF'
from typing import *
import subprocess
import shlex

def run_cmd(
    cmd: str,
    stdin=bytes(),
    raise_on_error=True
):
    process = subprocess.Popen(
        shlex.split(cmd),
        stdin=subprocess.PIPE,
    )
    process.wait()
    if raise_on_error and process.returncode != 0:
        raise Exception()

class CmdResult(NamedTuple):
    stdout: str
    stderr: str

def run_cmd_complex(
    cmd: str,
    stdin=bytes(),
    raise_on_error=True,
) -> CmdResult:
    process = subprocess.Popen(
        shlex.split(cmd),
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    stdout, stderr = process.communicate(input=stdin)
    process.wait()
    if raise_on_error and process.returncode != 0:
        raise Exception(stdout.decode() + stderr.decode())
    else:
        return CmdResult(stdout.decode(), stderr.decode())
EOF
)

DOM_HELP=$(<<'EOF'
import sys

run_cmd("which cd")
print('hi', file=sys.stderr)
print('hi')
EOF
)
#DOM_HELP="$DOM_RUN_CMD\n$DOM_HELP"
DOM_HELP=$(printf "%s\n\n%s" $DOM_RUN_CMD $DOM_HELP)

help()
{
   python3 -c "$DOM_HELP" 
   echo 'To view all aliases, environment variables, or functions
use "alias", "env", or "compgen -A function"!'
}

# idea:we want to join pdfs with format `pdfs a.pdf b.pdf > res.pdf`
# pdfrw is a library that only supports writing to files (not stdout)
DOM_PY_JOIN_PDFS=$(<<'EOF'
import sys

import pdfrw

pdf_writer = pdfrw.PdfWriter()

# argument layout:
# 0: -c
# 1: --output
# 2: "$temp_file"
# 3: a.pdf
# 4: b.pdf
# ...

for pdf_name in sys.argv[3:]:
    pdf = pdfrw.PdfReader(pdf_name)
    pdf_writer.addpages(pdf.pages)

pdf_writer.write(sys.argv[2])

with open(sys.argv[2], "rb") as f:
    f_read = f.read()
    with open("/dev/tty", "w") as f_tty:
        print(type(f_read), file=f_tty)
    sys.stdout.buffer.write(f_read)
EOF
)

dom_join_pdfs()
{
	temp_file=$(mktemp)
        echo "$temp_file" > /dev/tty
	python3 -c "$DOM_PY_JOIN_PDFS" --output "$temp_file" "$@"
}
alias pdfs="dom_join_pdfs"

alias bi="dom_brew_info"
dom_brew_info()
{
	brew info "$@"
        echo ""
        echo "# DEPENDENCIES"
	brew deps --tree "$@"
}
#mail
# alias gm="cmdg"
alias cal="gcalcli"
#alias cu="gcalcli agenda $(q -t "today") $(q -t "today + 2 week") --details url | cat"
alias cw=dom_gcalcli_calw
dom_gcalcli_calw()
{
	cal calw $(q -t "today") 2 --monday --width 25 "$@" | cat
}
alias ca="c agenda --details url --details description"
alias b="brew"
#https://superuser.com/a/1514591/852686
zstyle ':completion:*' completer _expand_alias _complete _ignored
#alias di="kitty +kitten diff"
alias diff=di
ENABLE_CORRECTION="true"
eval "$(thefuck --alias fuck)"
alias fu="fuck"
DOM_RG_LESS()
{
    # if you pipe something into less it doesn't 
    rg --pretty "$@" | less
}
DOM_RGA_LESS()
{
    rga --pretty "$@" | less
}
alias rgl="DOM_RG_LESS"
alias rgal="DOM_RGA_LESS"
alias ❯=""
#display mime type
alias file="file -I"
# original:
# import site; for dir in site.getsitepackages(): print(dir)
# python does not alow semicolons before compound statements like `for`
# (see https://stackoverflow.com/questions/24293128/why-cant-use-semi-colon-before-for-loop-in-python)
# so instead using this hack:
alias psp='python3 -c "import site; [print(dir) for dir in site.getsitepackages()]"'
alias pus='python3 -c "import site; print(site.USER_SITE)"'
function dom_mackup_apps() {
    # todo replace by $PIPX_LOCAL_VENVS (move this after pipx init)
    if [[ -d "/Users/dteiml/.local/pipx/venvs/mackup/lib/python3.11/site-packages/mackup/applications" ]]; then
        cd "/Users/dteiml/.local/pipx/venvs/mackup/lib/python3.11/site-packages/mackup/applications"
    else
        cd "$(psp)/mackup/applications"
    fi
}
alias ma=dom_mackup_apps
MA="$(psp)/mackup/applications"
alias md="cd $HOME/.mackup"
alias w="which"
alias sp="spt"
alias rhs="hs -c 'hs.reload()'"
ec() {
    if [[ $# -eq 0 ]]
    then
        code .
    elif [ -d $1 ]
    then
        cd $1 && code .
    else
        code --new-window $1
    fi
}
# https://askubuntu.com/a/847305
zle_highlight+=(paste:none)


export GOKU_EDN_CONFIG_FILE="/Users/dteiml/Dropbox/Mackup/.config/karabiner/karabiner.edn"

DIACRITICS="from
https://www.wikiwand.com/en/Diacritic
ó acute 
ò grave 
ů ring 
ô circumflex
ǒ caron
ő doubel acute
ȍ double grave 
õ tilde
ŏ breve
ȏ inverted breve 
ö diaeresis (umlaut)
"
#autoload -U +X compinit && compinit
#compdef hg=rg
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/bin/sync:$PATH"
compdef _rg hg
compdef _diff di
alias lp="cd ~/iCloud/iCloud~com~logseq~logseq/Documents/pages"
alias ex="exec zsh -l"
alias kl="kitty @ launch --hold --cwd current zsh -c"
alias klkf="kitty @ launch --hold --cwd current --keep-focus zsh -c"
alias ks="kitty @ send-text --match"
# --no-ignore - don't respect .(git|fd)files
# alias fdi="fd -I"
alias u="kitty +kitten unicode_input | c"
expand_aliases_on_space()
{
globalias()
{
    zle _expand_alias
    zle expand-word
    zle self-insert
}
zle -N globalias
bindkey -M emacs " " globalias
bindkey -M viins " " globalias
}
cdd()
{
    cd "$(dirname $1)"
}
alias ...='cd .. && cd ..'
alias ....='cd .. && cd .. && cd ..'
alias .....='cd .. && cd .. && cd .. && cd ..'
alias ......='cd .. && cd .. && cd .. && cd .. && cd ..'
alias .......='cd .. && cd .. && cd .. && cd .. && cd .. && cd ..'
alias ........='cd .. && cd .. && cd .. && cd .. && cd .. && cd .. && cd ..'
alias .........='cd .. && cd .. && cd .. && cd .. && cd .. && cd .. && cd .. && cd ..'
alias -g H='--help | cat'
alias -g R='| hg'
alias -g B='| bat'
alias -g L='| less'
alias -g C='| c'
alias -g N='| nvim -'
alias matrix=cmatrix
# alias kl='kitty @ goto-layout'


dom-repeat() {
    for i in {1..$2}; do echo -n "$1"; done
}

dom-file-sep() {
    echo -n '    '
    # using en-dash here (U+2013) because regular dash is used by zsh to terminate option processing (see [so-echo-dash])
    _path=$(grealpath $1)
    dom-repeat '–' "${#_path}"
    echo
    echo -n '    '
    echo $_path
    echo -n '    '
    dom-repeat '–' "${#_path}"
    echo
}

# dom-echo-dir() {
#     for file in $(ls -1); do dom-file-sep $file; \cat $file; done
# }

# alias ecd=dom-echo-dir

# dom-echo-dir-r() {
#     for file in **/*; do dom-file-sep $file; \cat $file; done
# }

# alias ecdr=dom-echo-dir-r

DOM_SCC_DIRS()
{
    for file in $(ls -1); do dom-file-sep $file; scc $file; done B
}

alias sccds=DOM_SCC_DIRS


# see [so-zsh-ctrl-d]
exit_zsh_d() { exit }
zle -N exit_zsh_d
bindkey '^d' exit_zsh_d
bindkey -M vicmd '^d' exit_zsh_d

# # cmd+backspace (custom in kitty.conf)
# bindkey -M viins '^[[127;9u' zvm_backward_kill_line 
# bindkey -M vicmd '^[[127;9u' zvm_backward_kill_line

# # cmd+delete (cmd+fn+backspace on kb-air) (custom in kitty.conf)  
# bindkey -M viins '^[[3;9~' zvm_forward_kill_line
# bindkey -M vicmd '^[[3;9~' zvm_forward_kill_line

# # option+backspace (custom in kitty.conf)
# bindkey -M viins '^[[127;3u' backward-kill-word
# bindkey -M vicmd '^[[127;3u' backward-kill-word

# # option+delete (option+fn+backspace on kb-air) (custom in kitty.conf)
# bindkey -M viins '^[[3;3~' kill-word
# bindkey -M vicmd '^[[3;3~' kill-word

# bindkey -M viins '^C' kill-whole-line
# bindkey -M vicmd '^C' kill-whole-line
# bindkey -M emacs '^C' kill-whole-line

# cmd+left (F28)
bindkey -M viins '^[[57391u' beginning-of-line
bindkey -M vicmd '^[[57391u' beginning-of-line

# cmd+right (F29)
bindkey -M viins '^[[57392u' end-of-line
bindkey -M vicmd '^[[57392u' end-of-line

# cmd+backspace (F30)
bindkey -M viins '^[[57393u' zvm_backward_kill_line
bindkey -M vicmd '^[[57393u' zvm_backward_kill_line

# cmd+delete (F31)
bindkey -M viins '^[[57394u' zvm_forward_kill_line
bindkey -M vicmd '^[[57394u' zvm_forward_kill_line

# alt+left (F32)
bindkey -M viins '^[[57395u' backward-word
bindkey -M vicmd '^[[57395u' backward-word

# alt+right (F33)
bindkey -M viins '^[[57396u' forward-word
bindkey -M vicmd '^[[57396u' forward-word

# alt+backspace (F34)
bindkey -M viins '^[[57397u' backward-kill-word
bindkey -M vicmd '^[[57397u' backward-kill-word

# alt+delete (F35)
bindkey -M viins '^[[57398u' kill-word
bindkey -M vicmd '^[[57398u' kill-word

alias ks="kitty +kitten show_key"

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias vivaldi="/Applications/Vivaldi.app/Contents/MacOS/Vivaldi"

alias gmd='gh repo view'
alias gbr='gh browse --repo'

function dom_ranger() {
    if ranger --choosedir=$HOME/.rangerdir "$@"; then
    		LASTDIR=`cat $HOME/.rangerdir`
    		cd "$LASTDIR"
    fi
}
alias r=dom_ranger
export GOPATH="$HOME/go" # this is also the default location
export PATH="$PATH:$GOPATH/bin"

alias lg=lazygit

function s() {
    sl "$@";
    if [[ "$#" = 0 ]]; then
        sl st;
    else
        sl; sl st;
    fi
}
eval "$(register-python-argcomplete pipx)"

function pr() {
    # bat --decorations always "$@" | nvim +'colorscheme github_light' +'set syntax=python' - +'TOHtml'
    # bat --decorations always "$@" | nvim +'colorscheme github_light' +'augroup AuSplit | autocmd! | augroup END' -
    files="${@:2}"
    bat --decorations always $(echo $files) | nvim --headless --clean \
    		+'set number' \
    		+'set packpath+=/Users/dteiml/.local/share/nvim.astro/site' \
    		+'packadd github_nvim_theme' \
    		+'colorscheme github_light' \
    		+"set syntax=$1" \
    		+"source $(brew --prefix)/Cellar/neovim/0.9.0/share/nvim/runtime/syntax/2html.vim" \
				+'wqa!' \
		-
		open Untitled.html
		# trash Untitled.html
}

export PATH="/Users/dteiml/.local/bin:$PATH"
alias py7="pyenv global 3.7.12"
alias py10="pyenv global 3.10.0"
alias pln="pip list --not-required"
alias pd="pdm run"
alias fd="command fd --hidden --no-ignore"

# packer update (`ps`) is already taken
alias pu="nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'" 

# https://unix.stackexchange.com/a/92448
chr () {                                                              
    # converts decimal value to its ASCII character representation
  local val                                                           
  [ "$1" -lt 256 ] || return 1                                        
  printf -v val %o "$1"; printf "\\$val"                             
  # That one requires bash 3.1 or above.                              
}                                                                     

ord() {                     
    # converts ASCII character to its decimal value
  # POSIX                   
  LC_CTYPE=C printf %d "'$1"
}

function dom_rename() {
    # set -x
 #    # for all files starting with characters between args 1 and 2, increment the starting character
 #    start=$(ord "$1")
 #    end=$(ord "$2")
 #    offset="$3"
 #    for i in $(seq $start $end); do
	# char=$(chr $i)
	# for file in $char_*; do
	#     new=$(chr $(($i + $offset)))
	#     mv "$file" "${file/$char/$new}"
	# done
 #    done
    offset="$1"
    args="${@:2}"
    for file in $(echo $args); do
				new=$(chr $(($(ord ${file:0:1}) + $offset)))
				# not using this bc it is causing problems when the files are not tracked with git
				# if is git directory
				# if git rev-parse --show-toplevel &> /dev/null; then
				# 		git mv "$file" "${file/${file:0:1}/$new}"
				# else
					mv "$file" "${file/${file:0:1}/$new}"
		# fi
		done
}

alias inc='dom_rename 1'
alias dec='dom_rename -1'

function dom_alt() {
    # if arg exists, prefix it with _
    # if arg with _ exists, remove _
    local dirname=$(dirname "$1")
    # echo $dirname # for debugging
    local basename=$(basename "$1")
    # echo $basename # for debugging
    local cwd=$(\pwd)
    # echo $cwd # for debugging
    cdn "$dirname"
    if [[ -e "$basename" ]] && [[ -e "_$basename" ]]; then
	echo "Both $1 and _$1 exist"
	exit 1
    fi
    if [[ -e "$basename" ]]; then
	# case x -> _x
	echo "Renaming $1 to _$basename"
	mv "$basename" "_$basename"
	echo "$1 has been renamed to _$basename :-)"
    elif [[ -e "_$basename" ]]; then
	# case _x -> x
	echo "Renaming $dirname/_$basename to $1"
	mv "_$basename" "$basename"
	echo "$dirname/_$basename has been renamed to $1 :-)"
    fi
    cdn "$cwd"
}

alias alt=dom_alt

alias astrovim='mv ~/.config/nvim ~/.config/nvim.bak; mv ~/.local/share/nvim ~/.local/share/nvim.bak; mv ~/.config/nvim-astro ~/.config/nvim; mv ~/.local/share/nvim-astro ~/.local/share/nvim'
alias domvim='mv ~/.config/nvim ~/.config/nvim-astro; mv ~/.local/share/nvim ~/.local/share/nvim-astro; mv ~/.config/nvim.bak ~/.config/nvim; mv ~/.local/share/nvim.bak ~/.local/share/nvim'
alias pwd='grealpath .'
alias pack='r ~/.local/share/nvim/site/pack/packer'
KITTY_CLONE_SOURCE_CODE="echo ho"
alias kd="kitty +kitten diff"
alias pl="pip list --not-required"
# pip list all
alias pla="pip list"

function fz() {
    fzf -f "$1" | head -n 1
}

function ef() {
    # e `fz "$1"`
    nvim `fzf -f "$1" | head -n 1`
}
function cf() {
    # e `fz "$1"`
    cat `fzf -f "$1" | head -n 1`
}
function ec() {
    cd "$1"
    shift
    nvim "$@"
}

# export CC=$(\which gcc-13)
# make vim yank do system clipboard
# from https://github.com/jeffreytse/zsh-vi-mode/issues/19#issuecomment-1009256071
function zvm_vi_yank() {
	zvm_yank
	echo ${CUTBUFFER} | pbcopy
	zvm_exit_visual_mode
}
# export CC="/opt/homebrew/bin/gcc-13"
# export cc="/opt/homebrew/bin/gcc-13"
alias cfg='/usr/bin/git --git-dir=$HOME/p/hacker-dom/bare/domfiles --work-tree=$HOME/Dropbox/Mackup'

function dom_git_csv() {
    echo 'commit,author,description,timestamp'
}

alias gcsv='dom_git_csv'

eval "$(_WOKE_COMPLETE=zsh_source woke)"

export PATH="$HOME/bin/sync:$HOME/bin:$PATH"

function adoc() {
    asciidoctor "$1" && open -a "Brave Browser" "${1%.*}.html"
}

alias ewl="nvim /Users/dteiml/.local/share/nvim/lazy/nvim-lspconfig/lua/lspconfig/server_configurations/woke.lua"

# REFERENCES
# [so-echo-dash]: https://stackoverflow.com/a/57656708/4204961
# [so-zsh-ctrl-d]: https://superuser.com/a/1452645/852686

# This needs to go at the end, since it will be sourcing a `.venv/bin/actiave` file and hence prepending to $PATH (In particular, it needs to go after eg code that adds pipx to path).
# handle_venv

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
