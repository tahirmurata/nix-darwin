if status is-interactive
    # Commands to run in interactive sessions can go here

    abbr --add lg lazygit
    abbr --add ll ls -lh

    source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
end
