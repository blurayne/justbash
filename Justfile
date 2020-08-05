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
