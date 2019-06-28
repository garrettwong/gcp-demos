#!/bin/sh

sudo bash -c 'cat << EOF > /usr/local/bin/gs
git status
EOF'
sudo chmod +x /usr/local/bin/gs

sudo bash -c 'cat << EOF > /usr/local/bin/gb
git branch
EOF'
sudo chmod +x /usr/local/bin/gb

sudo bash -c 'cat << EOF > /usr/local/bin/gpm
git push -u origin master
EOF'
sudo chmod +x /usr/local/bin/gpm

sudo bash -c 'cat << EOF > /usr/local/bin/gc
git commit -m "\$1"
EOF'
sudo chmod +x /usr/local/bin/gc



