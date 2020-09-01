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
- Coloring of STDERR
- Show output copy’n’paste style with [renvsubst](https://github.com/FujiHaruka/renvsubst)

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
curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to $HOME/.local/bin
```

### Install Justbash

``` bash
curl --progress-bar -sSfL https://raw.githubusercontent.com/blurayne/justbash/main/Justbash -o - \
	| install -m 755 /dev/stdin "$PREFIX/bin/Justbash"
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
- Get `shenvsubst` ready

## Trackback

- https://github.com/microsoft/just

- https://github.com/FujiHaruka/renvsubst

  
