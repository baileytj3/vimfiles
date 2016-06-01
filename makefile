.PHONY: default install link-file link-folder update vim-plug

default: install

install: link-folder link-file vim-plug plugins

vim-plug:
	@echo "==> Downloading vim-plug"
	@mkdir -p $(CURDIR)/autoload
	@$(DLCMD) $(CURDIR)/autoload/plug.vim \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

link-file:
	@echo "==> Symlinking Vim config file into $(HOME)"
	@ln -sfn "$(CURDIR)/.vimrc" "$(HOME)/.vimrc"

link-folder:
	@echo "==> Symlinking Vim folder into $(HOME)"
	@if [ "$(CURDIR)" != "$(HOME)/.vimrc" ]; then				\
		ln -sfn "$(CURDIR)" "$(HOME)/.vim";				\
	 fi

plugins: vim-plug
	@echo "==> Installing plugins"
	@vim -u $(CURDIR)/.vimrc +PlugUpgrade +PlugInstall +qall

clean:
	@echo "==> Removing installed plugins"
	@$(RM) -rf $(CURDIR)/bundle $(CURDIR)/plugged
	@echo "==> Removing vim-plug"
	@$(RM) -rf $(CURDIR)/autoload/plug.vim
	@echo "==> Unlinking .vim/.vimrc"
	@if [ -L $(HOME)/.vim ]; then			\
		$(RM) $(HOME)/.vim;					\
	 fi
	@if [ -L $(HOME)/.vimrc ]; then			\
		$(RM) $(HOME)/.vimrc;				\
	 fi

WGET := $(shell command -v wget;)
CURL := $(shell command -v curl;)

ifdef WGET
	DLCMD := $(WGET) -o
else ifdef CURL
	DLCMD := $(CURL) -sLo
else
	@echo "Neither curl nor wget are installed"
	exit
endif
