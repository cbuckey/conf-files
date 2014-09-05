alias shark='ssh cbuckey@shark.ics.cs.cmu.edu'
alias kcc='gcc -Wall -Wextra -ansi -pedantic -Werror'
alias cc0ref='/afs/cs.cmu.edu/academic/class/15411-f11/bin/cc0'
# export PATH=/usr/local/bin:$PATH:/Users/cbuckey/bin:/Applications/Octave.app/Contents/Resources/bin/
export PATH=/usr/local/bin:$PATH:/usr/local/octave/3.8.0/bin:~/bin
alias a='gls --color'
export EDITOR=vim

# set a fancy prompt (non-color, unless we know we "want" color)
# case "$TERM" in
#     xterm-color) color_prompt=yes;;
# esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi  
fi

# Turn on git tab completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

if [ -f ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
fi


# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\H\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\H:\W\$ '
# fi
# unset color_prompt force_color_prompt
# export PS1="\[\033[0;36m\]\h:\W \u\$ \[\033[0m\]"
# export PS1="\[\033[0;36m\]\W \[\033[0;34m\]\u \[\033[0;35m\][\t]\$ \[\033[0m\]"
export GIT_PS1_SHOWDIRTYSTATE=1
# export PS1="\[\033[1;36m\]\w\[\033[1;34m\]\$(__git_ps1) \[\033[1;35m\][\A]\\n\[\033[0;36m\]$ \[\033[0m\]"
# export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '

alias hidden='ls -a | grep "^\..*"'
bind "set completion-ignore-case on"
# ssh-add

export PATH=$PATH:/Users/quizqueen/Downloads/apktool-install-macosx-r05-ibot:/Library/Frameworks/Python.framework/Versions/3.3/bin

# Prevents hidden files from being tab-completed unless the dot has already
# been specified
bind 'set match-hidden-files off'

# Prevent duplicate lines from being added to bash history
export HISTCONTROL=ignoredups

export PYTHONPATH=/Users/cbuckey/courses/libraries/scikit-learn

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
