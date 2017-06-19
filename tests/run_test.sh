#!/bin/bash -eu

function red_echo() {
    echo -e "\033[31m$@\033[0m"
}

function greeen_echo() {
    echo -e "\033[32m$@\033[0m"
}

image=$1
error_code=0

for cmd in ffmpeg ; do
	if [[ "$(type -p $cmd)" == '' ]]; then
		red_echo "[Failed] Command $cmd is not found: $(type -p $cmd)"
		error_code=1
    else
		greeen_echo "[Passed] $cmd is found."
	fi
done

for file in tests/*.ml ; do
    stdout=$(cat $file | docker run -i --rm --link mysql:mysql --link postgres:postgres $image ocaml -init /home/opam/.iocamlinit)
    if echo "$stdout" | grep -i 'error\|failure\|exception' >/dev/null; then
		red_echo "[Failed] $file"
		error_code=1
    else
		greeen_echo "[Passed] $file"
    fi
    echo "$stdout"
done

exit $error_code
