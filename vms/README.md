## Recommended Linux lab environments

- Windows (amd64)
  - VirtualBox
  - Hyper-V
  - WSL Ubuntu distro
- macOS (amd64): VirtualBox
- macOS (arm64): parallels/vmware

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
