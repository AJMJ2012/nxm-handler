PREFIX ?= ~/.local
PREFIX := $(shell realpath "$(PREFIX)")

.SILENT:

nothing:

.PHONY: install
install:
	install -Dm755 nxm-handler "$(PREFIX)/bin/nxm-handler"
	cat nxm-handler.desktop | sed "s@%PREFIX%@$(PREFIX)@" > nxm-handler.desktop.tmp
	install -Dm644 nxm-handler.desktop.tmp "$(PREFIX)/share/applications/nxm-handler.desktop"
	rm nxm-handler.desktop.tmp
	cp ~/.config/mimeapps.list mimeapps.list.tmp
	sed "s|\[Default Applications\]|\0\\nx-scheme-handler/nxm=nxm-handler.desktop;|" mimeapps.list.tmp > ~/.config/mimeapps.list
	rm mimeapps.list.tmp
	update-desktop-database

.PHONY: uninstall
uninstall:
	rm -f "$(PREFIX)/bin/nxm-handler"
	rm -f "$(PREFIX)/share/applications/nxm-handler.desktop"
	rmdir --ignore-fail-on-non-empty -p "$(PREFIX)/bin"
	rmdir --ignore-fail-on-non-empty -p "$(PREFIX)/share/applications"
	cp ~/.config/mimeapps.list mimeapps.list.tmp
	grep -vF "x-scheme-handler/nxm=nxm-handler.desktop" mimeapps.list.tmp > ~/.config/mimeapps.list
	rm mimeapps.list.tmp
	update-desktop-database
