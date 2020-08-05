.PHONY: install

PREFIX?=$$HOME/.local
ifeq ($(EUID),0)
	PREFIX="/usr/local"
endif

PATH_BIN=$(PREFIX)/bin
PATH_SHARE=$(PREFIX)/share/

install: install-justbash

install-justbash:
	curl --progress-bar -sSfL https://raw.githubusercontent.com/blurayne/justbash/main/Justbash -o - \
	| install -m 755 /dev/stdin "$(PATH_BIN)/Justbash"

install-just:
	TMP=$$(mktemp -d) \
		&& curl --progress-bar -o - -SLf "https://github.com/casey/just/releases/download/v0.7.1/just-v0.7.1-x86_64-unknown-linux-musl.tar.gz" \
		| tar -C "$$TMP" -zxf -; \
		install -D -m 755 $$TMP/just "$(PATH_BIN)/just"; \
		install -D $$TMP/just.1 "$(PATH_SHARE)/man/man1/"; \
		install -D $$TMP/LICENSE "$(PATH_SHARE)/share/doc/just/copyright"; \