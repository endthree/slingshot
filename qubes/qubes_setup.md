# Qubes Setup

Qubes configuration and setup instructions



### Supend / Resume

On the ASUS Zenbook UX461F after you close the lid to suspend/sleep the computer it will not wake from sleep, so we need to change the sleep kernel parameter to `deep`

https://www.qubes-os.org/doc/suspend-resume-troubleshooting/#suspend-turns-off-the-screen-and-gets-stuck

```sh
# add mem_sleep_default=deep to GRUB_CMDLINE_LINUX
sudo vim /etc/default/grub
# apply 
sudo grub2-mkconfig -o /boot/efi/EFI/qubes/grub.cfg
# reboot then verify
cat /sys/power/mem_sleep
```


### Install TLP

https://linrunner.de/tlp/introduction.html

```sh
sudo qubes-dom0-update tlp
```

```sh
# then change /etc/tlp.conf settings to:
TLP_ENABLE=1
TLP_DEFAULT_MODE=BAT
TLP_PERSISTENT_DEFAULT=1
# start
sudo tlp start
# check if enabled
tlp-stat -s # State = enabled
```


### Install AwesomeWM

```sh
sudo qubes-dom0-update awesome
```
Then copy config and theme files to:

```sh
$HOME/.config/awesome/rc.lua
$HOME/.config/awesome/default/
```


### Setup dark mode in `dom0`

```sh
# System Tools > Appearance > Adwaita-dark
# System Tools > Window Manager > Style > Default

sudo qubes-dom0-update adwaita-qt5
# then add QT_STYLE_OVERRIDE=adwaita-dark to /etc/environment
```

The panel wouldn't change to dark theme, had to add `xfce4-panel --restart` to `Application menu > System Tools > Session and Startup > Application Autostart` to have the panel restart on login.

---


### Setup template (Debian 12)

```sh
# install template (from dom0)
sudo qubes-dom0-update qubes-template-debian-12
```

```sh
# set the terminal theme

# Edit > Preferences > Colors > White on black
# select Show bold text in bright colors

# THIS PART IS NOT DONE YET

# save gnome-terminal preferences to file
dconf dump /org/gnome/terminal/ > $HOME/gterminal.preferences
# copy to skel
sudo cp gterminal.preferences /etc/skel/
# load gnome-terminal preferences
cat $HOME/gterminal.preferences | dconf load /org/gnome/terminal/
```

```sh
# add GTK dark theme

# https://forum.qubes-os.org/t/guide-xfce-global-dark-mode-in-qubes-4-0-4-1/10757

# make dir and create settings.ini file
mkdir $HOME/.config/gtk-3.0
sudo vim $HOME/.config/gtk-3.0/settings.ini
# add the following to the file
[Settings]
gtk-application-prefer-dark-theme=1
gtk-font-name=DejaVu Sans Book 12 
gtk-theme-name=Adwaita-dark
gtk-icon-theme-name=gnome
# copy to skel
sudo mkdir -p /etc/skel/.config/gtk-3.0
sudo cp $HOME/.config/gtk-3.0/settings.ini /etc/skel/.config/gtk-3.0

# set GTK env vars in profile
echo "export GTK_THEME=Adwaita:dark" >> $HOME/.profile
# copy to skel
sudo cp $HOME/.profile /etc/skel
```

```sh
# install VSCodium

# allow network access
# Settings > Basic > Net qube > sys-firewall

# https://vscodium.com/#install

# install wget
sudo apt install wget

# Add the GPG key of the repository
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
# Add the repository
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

# Update then install vscodium
sudo apt update && sudo apt install codium

# then install extensions

# disable network access
# Settings > Basic > Net qube > default (none)

# add application
# Settings > Applications > VSCodium

# copy extensions to skel
sudo cp -r $HOME/.vscode-oss /etc/skel
# copy user settings to skel
sudo mkdir -p /etc/skel/.config/VSCodium/User
sudo cp $HOME/.config/VSCodium/User/settings.json /etc/skel/.config/VSCodium/User
# copy user keybindings to skel
sudo cp $HOME/.config/VSCodium/User/keybindings.json /etc/skel/.config/VSCodium/User
```

```sh
# configure Firefox

# https://forum.qubes-os.org/t/firefox-default-setting-in-qubes-os/3046

# copy .mozilla dir to template
qvm-copy .mozilla # select template
# which copies the dir to $HOME/QubesIncoming/"vm_name"
# then move it to skel
mv $HOME/QubesIncoming/"vm_name"/.mozilla /etc/skel
# delete
rm -rf $HOME/QubesIncoming
```

```sh
# install github-cli

# https://github.com/cli/cli/blob/trunk/docs/install_linux.md

# install
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
# upgrade
sudo apt update
sudo apt install gh
```

```sh
# install latex
sudo apt install texlive-full
sudo apt install latexmk
```
