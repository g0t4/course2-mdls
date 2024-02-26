# fish versions:
#   centos9s has fish 3.3.1
#   ubuntu23.10 has 3.6.1
# fish 3.6+ needed
# - new history-pager (ctrl+R preset binding)
# - `fish_config theme` commands
# - advanced abbr features: i.e. --set-cursor

# *** bat ***
export BAT_PAGING=never
export BAT_STYLE=plain

if command -q batcat # -q => w/o output
    # if batcat exists (i.e. ubuntu) => define bat
    alias bat=batcat
end

# replace cat with bat
#   (abbr = text expansion/replacement only)
abbr cat bat



# TODO how do I wanna present this? should I wait to cover in the course and/or add this into final config.fish?
if not test -f ~/.config/fish/completions/docker.fish
    if not command -q docker
        echo "[WARN]: docker not found, cannot generate fish completions"
    else
        echo "[INFO]: generating docker completions for fish shell..."
        docker completion fish >~/.config/fish/completions/docker.fish
    end
end



# *** minimal prompt (no exit code, no git status, no username)
function fish_prompt
    echo -sn (set_color cyan) $hostname (set_color normal)
    echo -sn (set_color $fish_color_cwd ) " $PWD" (set_color normal)
    echo -n '$ '
end

set -U fish_greeting "" # no welcome message



# *** systemctl ***
abbr sc 'sudo systemctl'
abbr scs 'sudo systemctl status'
abbr scstart 'sudo systemctl start'
abbr scstop 'sudo systemctl stop'
abbr screstart 'sudo systemctl restart'
abbr screvert 'sudo systemctl revert'
abbr scenable 'sudo systemctl enable'
abbr scdisable 'sudo systemctl disable'
abbr sccat 'sudo systemctl cat'
abbr scedit 'sudo systemctl edit'
abbr scls 'sudo systemctl list-units'
abbr sclsf 'sudo systemctl list-unit-files'
abbr sclss 'sudo systemctl list-sockets'
abbr sclsd 'sudo systemctl list-dependencies'
# *** journalctl ***
abbr jc 'sudo journalctl -u'
abbr jcb 'sudo journalctl --boot -u'
abbr jcf 'sudo journalctl --follow -u'

# *** docker abbrs ***
abbr dc 'docker container'
abbr dca 'docker container attach'
abbr dcc 'docker container commit'
abbr dccp 'docker container cp'
abbr dcd 'docker container diff'
abbr dce 'docker container exec -i -t'
abbr dci 'docker container inspect'
abbr dck 'docker container kill'
abbr dcl 'docker container logs'
abbr dcpr 'docker container prune'
abbr dcps 'docker container ps'
abbr dcpsa 'docker container ps -a'
abbr dcr 'docker container run --name'
abbr dcri 'docker container run -i -t --rm'
abbr dcrie 'docker container run -i -t --rm --entrypoint'
abbr dcrin 'docker container run -i -t --name web -p 8080:80 nginx' # *** nginx container
abbr dcrm 'docker container rm -f'
abbr dct 'docker container top'
#
abbr din 'docker inspect'
#
abbr dsy 'docker system'
abbr dsydf 'docker system df'
abbr dsydfv 'docker system df -v'
abbr dsyi 'docker system info'
abbr dsypr 'docker system prune'
#
abbr di 'docker image'
abbr dih 'docker image history --no-trunc'
abbr dii 'docker image inspect'
abbr dils 'docker image ls'
abbr dilsa 'docker image ls --all'
abbr dipr 'docker image prune'
abbr dipull 'docker image pull'
abbr dipush 'docker image push'
abbr dirm 'docker image rm'
abbr dit 'docker image tag'
#
abbr dm 'docker manifest'
abbr dmi 'docker manifest inspect'
#
abbr dne 'docker network'
abbr dnec 'docker network connect'
abbr dned 'docker network disconnect'
abbr dnei 'docker network inspect'
abbr dnels 'docker network ls'
abbr dnepr 'docker network prune'
abbr dnerm 'docker network rm'
#
abbr dv 'docker volume'
abbr dvc 'docker volume create'
abbr dvi 'docker volume inspect'
abbr dvls 'docker volume ls'
abbr dvlsd 'docker volume ls -f=dangling=true'
abbr dvpr 'docker volume prune'
abbr dvrm 'docker volume rm'
#
abbr dx 'docker context'
abbr dxls 'docker context ls'
abbr dxu 'docker context use'
abbr dxud 'docker context use default'
abbr dxi 'docker context inspect'
abbr dxc 'docker context create'
abbr dxrm 'docker context rm'
abbr dxs 'docker context show'

# *** containerd ***
abbr ctr 'sudo ctr'
abbr ctrn 'sudo ctr namespaces ls'
# containers:
abbr ctrc 'sudo ctr container ls'
abbr ctrci 'sudo ctr container info'
abbr ctrcrm 'sudo ctr container rm'
# images:
abbr ctri 'sudo ctr image ls'
abbr ctripull 'sudo ctr image pull docker.io/library/'
abbr ctrirm 'sudo ctr image rm docker.io/library/'
# tasks:
abbr ctrtls 'sudo ctr task ls'
abbr ctrtps 'sudo ctr task ps' # by CID
abbr ctrta 'sudo ctr task attach'
abbr ctrtrm 'sudo ctr task rm'
abbr ctrtk 'sudo ctr task kill --all'
abbr ctrtks 'sudo ctr task kill --all --signal=SIGKILL'
abbr ctrtpause 'sudo ctr task pause'
abbr ctrtresume 'sudo ctr task resume'
abbr ctrtstart 'sudo ctr task start'
abbr ctrtexec 'sudo ctr task exec --tty --exec-id 100 '
# run:
abbr ctrr 'sudo ctr run -t --rm'
abbr ctrrnd 'sudo ctr run -d docker.io/library/nginx:latest web' # w/o host networking
abbr ctrrn 'sudo ctr run -t --rm --net-host docker.io/library/nginx:latest web' # w/ host networking

# *** tar ***
abbr tarx 'tar -xf' # e(x)tract
abbr tart 'tar -tf' # lis(t) / (t)est
abbr tarc 'tar --xz -cf'
abbr tarcg 'tar --gzip -cf'
abbr tarcb 'tar --bzip2 -cf'



# *** fish theme (colors)
# fish_config theme dump + prepend set to each line (instead of write to a theme file in ~/.config/fish/themes/)
# NOTE this will save these into ~/.config/fish/fish_variables which is fine, next startup can overwrite if needed
set fish_color_autosuggestion 555 brblack
set fish_color_cancel -r
set fish_color_command blue --bold
set fish_color_comment brblack
set fish_color_cwd green
set fish_color_cwd_root red
set fish_color_end A37ACC --bold
set fish_color_error brred --bold
set fish_color_escape brcyan
set fish_color_history_current --bold
set fish_color_host normal
set fish_color_host_remote yellow
set fish_color_keyword green
set fish_color_match --background=brblue
set fish_color_normal normal
set fish_color_operator A37ACC --bold
set fish_color_option cyan --bold
set fish_color_param cyan
set fish_color_quote yellow
set fish_color_redirection A37ACC --bold
set fish_color_search_match bryellow '--background=brblack'
set fish_color_selection white --bold '--background=brblack'
set fish_color_status red
set fish_color_user brgreen
set fish_color_valid_path --underline
set fish_pager_color_background
set fish_pager_color_completion normal
set fish_pager_color_description brblack yellow -i
set fish_pager_color_prefix normal --bold --underline
set fish_pager_color_progress 000 '--background=brwhite'
set fish_pager_color_secondary_background
set fish_pager_color_secondary_completion
set fish_pager_color_secondary_description
set fish_pager_color_secondary_prefix
set fish_pager_color_selected_background -r
set fish_pager_color_selected_completion
set fish_pager_color_selected_description
set fish_pager_color_selected_prefix



# *** PATH ***
set PATH $PATH /home/vagrant/.local/bin /home/vagrant/go/bin
# pipx installs to ~/.local/bin
# go installs to ~/go/bin
# doesn't hurt if path(s) not present



# *** bindings ***
# modify delay to consider if esc keypress is a sequence or standalone
set fish_escape_delay_ms 200 # 30ms is default and way too fast (i.e. esc+k is almost impossible to trigger)

function kill_whole_line_and_copy
    commandline -b | tr -d '\n' | osc-copy
    commandline -f kill-whole-line
end
bind \ek kill_whole_line_and_copy # esc+k yanks line to clipboard (via oscclip osc 52 over SSH)

# ctrl+c clear command line instead of cancel-commandline
bind \cc 'commandline -r ""'
