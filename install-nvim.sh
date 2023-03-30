#!/bin/bash 

# ---- install nvim ----
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract; ./quashfs-root/AppRun --version

# install LSP's
echo -e "\nalias ls='ls --color' \nalias ll='ls -la'\nalias vi='nvim'\nalias vim='nvim'" >> ~/.config/aliases.sh

# TODO add importing statements to .bashrc

dnf copr enable atim/starship -y; dnf install -y starship
echo 'eval "$(starship init bash)"' >> ~/.bashrc
