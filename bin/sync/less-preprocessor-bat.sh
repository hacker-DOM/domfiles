#!/usr/bin/env bash
set -e
SOURCEFILE="$2"
TEMPFILE="${3:-$(mktemp)}"
case "$1" in
    open) {
        bat --decorations=always --color=always --terminal-width=$(tput cols) "$SOURCEFILE" &> "$TEMPFILE"
        echo "$TEMPFILE"
    } ;;

    close) {
        rm "$TEMPFILE"
    } ;;
esac
