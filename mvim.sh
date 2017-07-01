#!/bin/sh

# for MacVim.app


binary="/Applications/MacVim.app/Contents/MacOS/Vim"
name="`basename "$0"`"

case "$name" in
    *vimdiff)
        opts="$opts -dO"
        ;;
esac

exec "$binary" -g $opts ${1:+"$@"}
