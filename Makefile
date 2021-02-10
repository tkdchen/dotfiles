
INSTALL_BIN=install -m 664 -b --suffix="$(date +'-%Y%m%d-%H%M%S')"

.PHONY: install-bashrc
install-bashrc:
	@$(INSTALL_BIN) config-files/bashrc $(HOME)/.bashrc

.PHONY: install-nvim-init
install-nvim-init:
	@[ -e "$(HOME)/.config/nvim/" ] || mkdir -p $(HOME)/.config/nvim
	@$(INSTALL_BIN) config-files/nvim-init.vim $(HOME)/.config/nvim/init.vim

.PHONY: install-vimrc
install-vimrc:
	@$(INSTALL_BIN) config-files/vimrc $(HOME)/.vimrc

.PHONY: install-config-files
install-config-files: install-bashrc install-nvim-init install-vimrc

