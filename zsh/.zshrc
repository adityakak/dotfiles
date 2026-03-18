if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

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
