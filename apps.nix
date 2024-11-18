{ pkgs, ... }:

{
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Development tools
    vim
    neovim

    # Prompt
    pure-prompt

    # Programming languages
    nil
    nixpkgs-fmt
    go
    gopls
    templ

    # Programming cli
    pnpm
    wgo

    # CLI tools

    # General
    btop
    fastfetch
    bat
    lazygit
    ripgrep

    # Encryption
    age
  ];

  environment.variables.EDITOR = "nvim";

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
    };
    # updates homebrew packages on activation,
    # can make darwin-rebuild much slower (otherwise i'd forget to do it ever though)
    casks = [
      "hammerspoon"
      "firefox"
      "visual-studio-code"
      "kitty"
      "discord"
      "iina"
      "alt-tab"
      "tailscale"
    ];
  };
}
