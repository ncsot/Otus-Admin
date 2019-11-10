sudo yum -y install  https://centos7.iuscommunity.org/ius-release.rpm
sudo yum install -y tmux2u
touch ~/.tmux.conf
mkdir ~/.tmux
git clone https://github.com/tmux-plugins/tmux-logging ~/.tmux
echo "run-shell ~/.tmux/logging.tmux" > ~/.tmux.conf
tmux new -t kernel-compile -d
tmux source-file ~/.tmux.conf