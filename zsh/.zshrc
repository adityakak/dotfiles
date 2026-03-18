# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions ssh-agent copyfile copypath zsh-syntax-highlighting)
zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent lazy yes
zstyle :omz:plugins:ssh-agent identities id_ed25519 
# zstyle :omz:plugins:ssh-agent identities gitlab id_ed25519

source $ZSH/oh-my-zsh.sh
#export DISPLAY=$(grep nameserver /etc/resolv.conf | awk '{print $2}'):0.0
#export DISPLAY=$(ip route|awk '/^default/{print $3}'):0.0
# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#eval "$(starship init zsh)"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
if [ $(ps ax | grep "[s]sh-agent" | wc -l) -eq 0 ] ; then
    eval $(ssh-agent -s) > /dev/null
    if [ "$(ssh-add -l)" = "The agent has no identities." ] ; then
        # Auto-add ssh keys to your ssh agent
        # Example:
        ssh-add ~/.ssh/id_rsa > /dev/null 2>&1
    fi
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$PATH:/home/adi/.local/bin"
export PATH=/usr/local/cuda-12.1/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12.1/lib64:$LD_LIBRARY_PATH
export PATH=$PATH:/opt/viz
export PATH=$PATH:/opt/nvim-linux64/bin
export PATH=$PATH:/opt/llvm-19.1.3/bin
export LD_LIBRARY_PATH=/opt/llvm-19.1.3/lib
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export COLCON_DEFAULTS_FILE=$(realpath ~/car/cavauto/dockerimages/apptainer/defaults.yaml)

alias dbgqemu='qemu-system-aarch64 -M raspi3b -kernel ./kernel/kernel8-rpi3qemu.img -serial null -serial stdio -gdb tcp::63372 -S'
alias runqemu='bash run-rpi3qemu.sh'
# alias kmake='export PLAT=rpi3qemu; bash cleanall.sh; bash makeall.sh'
alias kmake='(export PLAT=rpi3qemu && bash cleanuser.sh && bash makeall.sh)'
alias gpu-status='cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status'
alias gpu-on='sudo prime-select on-demand && sudo systemctl gdm'
alias gpu-off='sudo prime-select intel && sudo systemctl gdm'
alias down='cd ~/Downloads'
alias humble='source /opt/ros/humble/setup.zsh'
alias zshconfig="nvim ~/.zshrc"
alias carsrc='source ~/car/cavauto/install/local_setup.zsh'
alias br="git for-each-ref --sort=committerdate refs/heads/ --format='%(HEAD) %(align:25,left)%(color:normal)%(refname:short)%(color:reset)%(end) %(color:normal dim)%(objectname:short)%(color:reset) %(color:green)(%(committerdate:relative))%(color:reset)'"
alias ssh-start='eval $(ssh-agent) && ssh-add ~/.ssh/id_ed25519'
alias cav='cd ~/car/cavauto'
alias cs='xclip -selection clipboard'
alias car_export='export LD_LIBRARY_PATH=/opt/libtorch/lib:$LD_LIBRARY_PATH && export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH && export LD_LIBRARY_PATH=/opt/blasfeo/lib:/opt/hpipm/lib:$LD_LIBRARY_PATH && export PYTHONPATH=~/code/school/ec/CAR/samirauto/install/graph_planner/lib/python3.10/site-packages/graph_planner:{PYTHONPATH} && export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/code/school/ec/CAR/cavauto/drivers/ros2_iris_driver/lib/vsomeip/build && export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/code/school/ec/CAR/cavauto/drivers/ros2_iris_driver/lib/boost/lib'
alias mamba_activate='source "${HOME}/miniforge3/etc/profile.d/conda.sh" && source "${HOME}/miniforge3/etc/profile.d/mamba.sh"'
alias ssh_school='ssh mbf3zk@portal.cs.virginia.edu'
alias cache='sudo sh -c "/usr/bin/echo 3 > /proc/sys/vm/drop_caches"'
alias entersim='docker exec -it cavauto_dev /bin/bash'
alias dockuh='docker stop $(docker ps -q)'
alias dockuhh='docker kill $(docker ps -q) && docker rm $(docker ps -aq)'
alias localsim="cd ~/cavauto; docker compose -f ./dockerimages/dspace_sim/docker-compose_cavauto.yml up"
alias killsim="docker compose -f ./dockerimages/dspace_sim/docker-compose_cavauto.yml down"
alias rsp="source ~/code/school/ec/CAR/cavauto/install/setup.sh && ros2 run robot_state_publisher robot_state_publisher ~/code/school/ec/CAR/cavauto/src/urdfs/urdf/av24.urdf"
alias cbu="colcon build --packages-up-to"
alias cbs="colcon build --packages-select"
alias watch_dir="watch ls -lh"
alias bags="cd ~/car/rosbags"
alias rnl="ros2 node list"
alias rtl="ros2 topic list"
alias rte="ros2 topic echo"
alias chess="/opt/en-croissant_0.11.1_amd64.AppImage"
alias ccd="code ."
# alias cs-server="ssh mbf3zk@portal07.cs.virginia.edu"
alias cs-server="ssh -J mbf3zk@portal.cs.virginia.edu mbf3zk@portal07.cs.virginia.edu"
alias lambda="ssh deepracing@deepracinglambda.linklab.virginia.edu"
alias internet-saving="sudo iw dev wlo1 set power_save off"
alias bli="rm -rf build/ log/ install/"
alias intel="sudo prime-select intel"
alias nvidia="sudo prime-select nvidia"

cdup() {
    # $1=number of times, defaults to 1
    local path
    printf -v path '%*s' "${1:-1}"
    cd "${path// /../}"
}

rcar() {
    rsync -avz --progress \
    -e "ssh -J mbf3zk@portal.cs.virginia.edu" \
    "mbf3zk@portal07.cs.virginia.edu:$1" \
    ~/car/downloads/
}
eval "$(zoxide init --cmd cd zsh)"

# ---- SSH agent bootstrap (silent) ----
AGENT_ENV="$HOME/.ssh/agent.env"

# If we have saved env vars, source them and verify the agent works
if [ -f "$AGENT_ENV" ]; then
  . "$AGENT_ENV" >/dev/null 2>&1
  ssh-add -l >/dev/null 2>&1 || {
    # saved env is stale; discard
    rm -f "$AGENT_ENV"
    unset SSH_AUTH_SOCK SSH_AGENT_PID
  }
fi

# If no working agent is known, start a new one and save its env
if [ -z "$SSH_AUTH_SOCK" ] || [ ! -S "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)" >/dev/null 2>&1
  mkdir -p "$HOME/.ssh"
  printf 'export SSH_AUTH_SOCK=%q\nexport SSH_AGENT_PID=%q\n' \
         "$SSH_AUTH_SOCK" "$SSH_AGENT_PID" > "$AGENT_ENV"
  chmod 600 "$AGENT_ENV"
fi

# Load your key only if not already loaded (completely silent if already there)
ssh-add -l >/dev/null 2>&1 || ssh-add "$HOME/.ssh/id_ed25519" >/dev/null 2>&1
# --------------------------------------

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/adi/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/adi/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/adi/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/adi/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/adi/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/adi/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
