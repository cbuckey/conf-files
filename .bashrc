# Turn on git tab completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

export GIT_PS1_SHOWDIRTYSTATE=1
# Prevent duplicate lines from being added to bash history
export HISTCONTROL=ignoredups
export PYTHONPATH=/Users/cbuckey/courses/libraries/scikit-learn
export HOMEBREW_GITHUB_API_TOKEN=51cd69725834e7cd29a8ab1a5167c2a26a2a4b45
export PATH=/usr/local/bin:$PATH:/usr/local/octave/3.8.0/bin:~/bin
export PATH=$PATH:/Users/quizqueen/Downloads/apktool-install-macosx-r05-ibot:/Library/Frameworks/Python.framework/Versions/3.3/bin
export EDITOR=vim

alias a='gls --color'
alias hidden='ls -a | grep "^\..*"'

bind "set completion-ignore-case on"
# Prevents hidden files from being tab-completed unless the dot has already
# been specified
bind 'set match-hidden-files off'

if [ -f ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
fi

# colors!
cyan=$(tput setaf 33) 
gray=$(tput setaf 242)
blue=$(tput setaf 27) 
green=$(tput setaf 28) 
yellow=$(tput setaf 221)
orange=$(tput setaf 202)
gold=$(tput setaf 100)
red=$(tput setaf 124)
purple="$(tput setaf 99)"

reset=$(tput sgr0)

# Colored based on whether the repo is currently dirty or not.
function git_repo_colored {

    # indicators for when there is something stashed/staged
    git_status="$(git status 2>&1)"

    # If we're in a git repo
    if [[ "$git_status" != *"Not a git repository"* ]]; then
        if [[ "$git_status" = *"nothing to commit"* ]]; then
            # Clean repository - nothing to commit
            git_repo_status_color=$green
        elif [[ "$git_status" = *"Changes not staged for commit"* ]]; then
            # unstaged local changes
            git_repo_status_color=$yellow
        elif [[ "$git_status" = *"nmerged"* ]]; then
            # Mid conflicted merge
            git_repo_status_color=$red
        else
            # ??? profit!
            git_repo_status_color=$green
        fi
    fi
}

# Nicer cwd printing
function smart_pwd {
    local pwdmaxlen=25
    local trunc_symbol=".."
    local dir=${PWD##*/}
    local tmp=""
    pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    new_pwd=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#new_pwd} - pwdmaxlen ))
    if [ ${pwdoffset} -gt "0" ]
    then
        tmp=${new_pwd:$pwdoffset:$pwdmaxlen}
        tmp=${trunc_symbol}/${tmp#*/}
        if [ "${#tmp}" -lt "${#new_pwd}" ]; then
            new_pwd=$tmp
        fi
    fi
}

PROMPT_COMMAND="git_repo_colored; smart_pwd"
export PS1='\[$blue\]$new_pwd\[$git_repo_status_color\]$(__git_ps1) \[$orange\][\A]$ \[$reset\]'
