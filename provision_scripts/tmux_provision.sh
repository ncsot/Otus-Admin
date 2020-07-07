#!/bin/bash
echo "Install tmux"
git clone https://github.com/tmux/tmux.git &&
cd ./tmux &&
sh ./autogen.sh &&
./configure && make && sudo make install

echo "Install tmux plugin"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf