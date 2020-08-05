# Justbash

## About

(This acts as extension for running `bash` commands in [Justfile](https://github.com/casey/just). 

Don’t mistake it for [Microsoft’s Just ](https://github.com/microsoft/just). But if I could steal some search results and link them to Rust it’s fine ;)

### Status

Currently I’m testing features and much things probably will change.

### Features

- Shared environment (by using PID from Just itself to create a temporary shared directory)
- Adding `@` before bash command will output the same before execution (like it’s in the file but with vars replaced)
  - Adding `@@`will print the exact same command
- Executing Justbash puts you in a shell with all the environment loaded
  - Setting `TMP` before execution puts you in the exact same environment like before
- Bash execution is strict started with
- Will load `Justfunctions`if present

### Bash Functions

Bundled functions like `noerr` ,`export` ,`import` will have an own page. Unless then please dig source code.

## Installation

### First step – don’t do system installations (until needed)

And yes we flow the XDG standard!

```bash
PREFIX="$HOME/.local"
if echo $PATH | tr ':' $'\n' | grep -qo "$PREFIX/bin"; then
	>&2 echo "Please export $PREFIX/bin to your PATH\!" 
fi
```

### Install Just (if not yet done)

```bash
TMP=$(mktemp -d)
curl -o - -SLf "https://github.com/casey/just/releases/download/v0.7.1/just-v0.7.1-x86_64-unknown-linux-musl.tar.gz" \
	| tar -c "$TMP" -zxvf -
install -D -m 755 just "$PREFIX/bin/just" \
install -D just.1 "$PREFIX/share/man/man1/" \
install -D LICENSE "$PREFIX/share/doc/just/copyright"
```

### Install Justbash

```bash
curl 
```

## Usage

```makefile
set shell := ["Justbash", "-c"]

export FROM_JUST := "with"

environment-foo:
	#!Justbash
	export MYVAR="1233"
	export FROM_JUST="love"
	
environment-bar:
	#!Justbash
	export AWS_FOO="$(aws get-some-important-id)"
	
foo: environment-foo
	#!Justbash
	title "Testing the environment"
	@echo "$MYVAR"
	@echo "$FROM_JUST"

foobar: environment-foo
	echo "$MYVAR"  # will run in an own Justbash process
	echo "$FROM_JUST" # will run in another Justbash process
```

## Todo

- `@@` annotation

- Better error handler (Just uses the lineno in the Justfile only)

  

## Trackback

- https://github.com/microsoft/just