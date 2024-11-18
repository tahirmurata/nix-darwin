{ pkgs, ... }:

{
  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    # Development tools
    vim
    neovim

    # Programming languages
    nil
    nixpkgs-fmt
    go
    templ

    # Programming cli
    pnpm
    wgo

    # CLI tools
    btop
    fastfetch
    bat
    lazygit
    ripgrep
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
