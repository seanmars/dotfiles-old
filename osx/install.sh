install() {
	printf "${GREEN}Install Homebrew...\n${NORMAL}"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	printf "${GREEN}Install brew Apps...\n${NORMAL}"
	brew install git wget tree thefuck ccat zsh gnu-sed

	printf "${GREEN}Add homebrew tap...\n${NORMAL}"
	brew tap caskroom/cask
	brew tap caskroom/fonts

	printf "${GREEN}Add fonts...\n${NORMAL}"
	brew cask install caskroom/fonts/font-fira-code
	brew cask install caskroom/fonts/font-firacode-nerd-font

	printf "${GREEN}Install iterm2...\n${NORMAL}"
	brew cask install iterm2

	printf "${GREEN}Install oh-my-zsh...\n${NORMAL}"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

setting() {
	printf "${GREEN}Download the color schema...\n${NORMAL}"
	wget https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Tomorrow%20Night%20Eighties.itermcolors -O tomorrow-night-eighties.itermcolors

	printf "${GREEN}Download the config...\n${NORMAL}"
	DIRECTORY=~/.myconfig
	if [ ! -d "${DIRECTORY}" ]; then
		mkdir ${DIRECTORY}
	fi
	wget https://raw.githubusercontent.com/seanmars/dotfiles/master/osx/.myconfig/oh-my-zsh-theme -O ~/.myconfig/oh-my-zsh-theme
	wget https://raw.githubusercontent.com/seanmars/dotfiles/master/osx/.myconfig/alias -O ~/.myconfig/alias

	printf "${GREEN}Download the theme powerlevel9k for oh-my-zsh...\n${NORMAL}"
	git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

	printf "${GREEN}Setting oh-my-zsh theme...\n${NORMAL}"
	SCRIPT="source .myconfig/oh-my-zsh-theme"
	TARGET=~/.zshrc
	THEME_STR="ZSH_THEME="
	if ! grep -q $SCRIPT $TARGET; then
		LINE=$(cat $TARGET | grep -n $THEME_STR | HEAD -1 | awk -F: '{print $1}')
		gsed -i "${LINE}a${SCRIPT}" $TARGET
		printf "${CYAN}Insert [${SCRIPT}] done.\n${NORMAL}"
	fi

	printf "${GREEN}Setting oh-my-zsh alias...\n${NORMAL}"
	SCRIPT="source .myconfig/alias"
	TARGET=~/.zshrc
	if ! grep -q $SCRIPT $TARGET; then
		echo "${SCRIPT}" >>${TARGET}
		printf "${CYAN}Insert [${SCRIPT}] done.\n${NORMAL}"
	fi

	printf "${RED}Type the following to change the shell:\n\n${NORMAL}"
	printf "\tsudo sh -c \"echo $(which zsh) >> /etc/shells\"\n"
	printf "\tchsh -s $(which zsh)\n"
	printf "\nReset the terminal...\n"
}

install
setting
