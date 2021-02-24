.PHONY: default
default: install

.PHONY: install
install: link-folder link-file vim-plug plugins

.PHONY: install
vim-plug:
	@echo "==> Downloading vim-plug"
	@mkdir -p $(CURDIR)/autoload
	@if [ ! -e "$(CURDIR)/autoload/plug.vim" ]; then \
		$(DLCMD) $(CURDIR)/autoload/plug.vim \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; \
	fi

.PHONY: link-file
link-file:
	@echo "==> Symlinking Vim config file into $(HOME)"
	@ln -sfn "$(CURDIR)/.vimrc" "$(HOME)/.vimrc"

.PHONY: link-folder
link-folder:
	@echo "==> Symlinking Vim folder into $(HOME)"
	@if [ "$(CURDIR)" != "$(HOME)/.vimrc" ]; then \
		ln -sfn "$(CURDIR)" "$(HOME)/.vim"; \
	 fi

.PHONY: plugins
plugins: vim-plug
	@echo "==> Installing plugins"
	@vim -u $(CURDIR)/.vimrc +PlugUpgrade +PlugInstall +qall

.PHONY: clean
clean:
	@echo "==> Unlinking .vim/.vimrc"
	@if [ -L $(HOME)/.vim ]; then \
		$(RM) $(HOME)/.vim; \
	 fi
	@if [ -L $(HOME)/.vimrc ]; then \
		$(RM) $(HOME)/.vimrc; \
	 fi

WGET := $(shell command -v wget;)
CURL := $(shell command -v curl;)

ifdef WGET
	DLCMD := $(WGET) -O
else ifdef CURL
	DLCMD := $(CURL) -sLo
else
	@echo "Neither curl nor wget are installed"
	exit
endif
