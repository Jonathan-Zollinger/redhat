#! /bin/bash
# installs nvim via appimage

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract; ./quashfs-root/AppRun --version

mv squashfs-root /
ln -s /squashfs-root/AppRun /usr/bin/nvim

rm ./nvim* -f
