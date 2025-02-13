#!/bin/bash

CONFIG_DIR="$HOME/nixconfig/config"

# Make sure ~/.config exists
mkdir -p "$HOME/.config"

# Loop through hidden and non-hidden items in $CONFIG_DIR
for item in "$CONFIG_DIR"/.* "$CONFIG_DIR"/*; do
    case "$(basename "$item")" in
        '.'|'..') continue ;;
    esac

    name="$(basename "$item")"

    # Directories go in ~/.config
    if [ -d "$item" ]; then
        [ -e "$HOME/.config/$name" ] && rm -rf "$HOME/.config/$name"
        ln -sf "$item" "$HOME/.config/$name"
    else
        # Everything else goes in ~
        [ -e "$HOME/$name" ] && rm -rf "$HOME/$name"
        ln -sf "$item" "$HOME/$name"
    fi
done
