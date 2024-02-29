## Recommended Linux lab environments

- Windows (amd64)
  - VirtualBox
  - Hyper-V
  - WSL Ubuntu distro
- macOS (amd64): VirtualBox
- macOS (arm64): parallels/vmware

## vagrant tips

```shell
# creating a VM is automated & fast!
# and, using snapshots (too) is even faster!
#
# i.e.
vagrant up
vagrant snapshot save before_foo # or, 'after_vagrant_up'
vagrant ssh # 🧪 ... install/config foo
vagrant snapshot save after_foo # 😷 just in case
vagrant snapshot list
# ... wanna redo foo?
vagrant snapshot restore before_foo
vagrant ssh # foo is gone 🎉
vagrant snapshot delete after_foo # good to go?
# ...
```

## (optional) disable Parallels modifying /etc/hosts

- Because the course VMs use host-only NICs, parallels adds entires to `/etc/hosts`
  - that way, the host can access VMs by name
    - i.e. `ssh VMNAME` or `ssh VMNAME.shared`
    - consequently, these `/etc/hosts` entries are added to `ssh <TAB>` completion
  - and, VMs can talk to each other (via shared DNS server @127.0.0.53)
- Separately, I use `vagrant ssh-config --host foo` to connect via `ssh foo`
  - ssh configured host entries are also added to tab completion
    - thus the parallels entries pollute tab completion needlessly, especially b/c vagrant generated VM names are verbose
- So, to disable parallels `/etc/hosts` entries:
  - https://kb.parallels.com/en/123300
  - FYI disabling this means VMs cannot ping each other by the VMNAME
    - IMO not a big deal b/c I wouldn't ever use the vagrant generated names to do so
    - can always add /etc/hosts entries

```shell
# check current config:
cat /Library/Preferences/Parallels/network.desktop.xml | grep NATDAllow

# make backup
cp /Library/Preferences/Parallels/network.desktop.xml backup.xml

# change 1 (enabled) => 0 (disabled)
#   preview:
sudo sed 's/<NATDAllowEtcHostsWrite>1<\/NATDAllowEtcHostsWrite>/<NATDAllowEtcHostsWrite>0<\/NATDAllowEtcHostsWrite>/' /Library/Preferences/Parallels/network.desktop.xml
#   apply (CAREFUL) -i == modify inline:
sudo sed -i '' 's/<NATDAllowEtcHostsWrite>1<\/NATDAllowEtcHostsWrite>/<NATDAllowEtcHostsWrite>0<\/NATDAllowEtcHostsWrite>/' /Library/Preferences/Parallels/network.desktop.xml
# restart parallels service:
sudo launchctl list | grep -i parallels # show service status (left most # is PID)
sudo launchctl stop com.parallels.desktop.launchdaemon
sudo launchctl start com.parallels.desktop.launchdaemon
#
# shutdown/restart VMs to remove their existing entries (or delete manually)
vagrant reload

```

### consistent SSH IP/PORT to a given VM ###

```Vagrantfile

# Attempt to force a constant IP/port for SSH
#   by assigning a static port mapped to the host, use localhost to access
#   works on initial vagrant up
#     works in vagrant ssh-config output
# but, "fixing this" can cause unforeseen issues, so don't "fix this"
#   b/c changing IP is relatively rare, i.e. on reboot w/ parallels VMs
#   and I'm not certain this working isn't by accident (would have to dig into vagrant code to see if its intended/guaranteed behavior that will be there in the future)
config.vm.network 'forwarded_port', host: "8230", guest: "22" # forward port for ssh, so vagrant ssh-config doesn't change (i.e. across host reboot)
config.ssh.host = "127.0.0.1"
config.ssh.port = "8230" # secondary issue => collision with host ports, plus the config is not straightforward

```