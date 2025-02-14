if status is-interactive
    # Commands to run in interactive sessions can go here

    # Remove fish_greeting
    set -g fish_greeting

    abbr --add lg lazygit

    # Ghostty manual shell integration
    if test -n "$GHOSTTY_RESOURCES_DIR"
        source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
    end
end
