

GO_VERSION=1.13
ARCHITETURE=$(shell dpkg --print-architecture)
GO_FILE_NAME=go${GO_VERSION}.linux-${ARCHITETURE}.tar.gz
GO_URL=https://dl.google.com/go/${GO_FILE_NAME}
export PATH:=$(PATH):/usr/local/go/bin:~/go/bin

KUBECTL_VERSION=$(shell curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
KUBECTL_URL=https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl


init:
	sudo apt update
	sudo apt install npm vim htop deepin-terminal meld git \
			software-properties-common curl python3-pip \
			apt-transport-https ca-certificates wget -y
	# disable swap
	sudo swapoff -a
	mkdir -p ~/.config/deepin/deepin-terminal/
	cp -f `pwd`/deepin-terminal_config.conf \
		~/.config/deepin/deepin-terminal/config.conf
	ln -sf `pwd`/eslintrc.json ~/.eslintrc.json
	ln -sf `pwd`/gitconfig ~/.gitconfig
	ln -sf `pwd`/tern-config ~/.tern-config
	gsettings set org.gnome.desktop.default-applications.terminal \
		exec deepin-terminal

install-deepinterminal:
	sudo apt install deepin-terminal
	mkdir -p ~/.config/deepin/deepin-terminal/
	cp -f `pwd`/deepin-terminal_config.conf \
		~/.config/deepin/deepin-terminal/config.conf
	gsettings set org.gnome.desktop.default-applications.terminal \
		exec deepin-terminal

install-gnome:
	sudo apt-get install chrome-gnome-shell

install-zsh:
	sudo apt install zsh

install-ohmyzsh:
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

install-git:
	sudo apt install git

install-atom:
	sudo snap install atom --classic

install-spotify:
	sudo snap install spotify

install-pycharm:
	sudo snap install pycharm-professional --classic

install-goland:
	sudo snap install goland --classic

install-disc:
	sudo snap install discord

install-chrome:
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb

install-go:
	wget ${GO_URL}
	mkdir tmp
	tar xzf ${GO_FILE_NAME} -C tmp/
	sudo cp -r tmp/* /usr/local/
	rm -rf ${GO_FILE_NAME} tmp

install-docker:
	sudo curl -fsSL https://get.docker.com | bash
	sudo usermod -aG docker ${USER}

install-kubectl:
	curl -LO ${KUBECTL_URL}
	chmod +x ./kubectl
	sudo mv ./kubectl /usr/local/bin/kubectl



install: \
	init \
	install-deepinterminal \
	install-go \
	install-docker \
	install-kubectl \
	install-zsh \
	install-ohmyzsh \
	install-git \
	install-atom \
	install-spotify \
	install-pycharm \
	install-goland \
	install-chrome \
	install-gnome \
	install-disc
