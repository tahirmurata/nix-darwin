{ inputs, pkgs, ... }:
{
  # The platform the configuration will be used on
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  # Environment Configuration
  environment.systemPackages =
    with pkgs;
    [
      # Development Tools
      ## Text Editors & IDEs
      # helix # Modern modal text editor

      ## Version Control
      gh # GitHub command line interface
      lazygit # Terminal UI for git
      jujutsu # A Git-compatible VCS that is both simple and powerful

      ## Programming Languages
      lldb # Next-generation high-performance debugger
      go # Go programming language
      gopls # Go language server
      gotools # Go development utilities
      nodejs_23 # JavaScript runtime environment
      pnpm # Fast and efficient JavaScript package manager
      bun # Incredibly fast JavaScript runtime, bundler, transpiler and package manager
      # cargo # Downloads your Rust project's dependencies and builds your project
      # rustc # Safe, concurrent, practical language (wrapper script)
      # rustfmt # Tool for formatting Rust code according to style guidelines
      # rust-analyzer # Modular compiler frontend for the Rust language
      uv # Extremely fast Python package installer and resolver, written in Rust
      ruff # Extremely fast Python linter and code formatter

      ## Nix Tools
      nixd # Nix language server
      nixfmt-rfc-style # Nix code formatter

      ## Document Processing
      typst # Modern markup-based typesetting system
      tinymist # Language service for Typst
      typstyle # Beautiful and reliable typst code formatter

      # System Utilities
      ## Monitoring & System Tools
      btop # System resource monitor
      fastfetch # System information display tool
      wgo # Go live reload utility
      age # Modern file encryption tool
      ffmpeg # Complete, cross-platform solution to record, convert and stream audio and video

      ## File Management
      yazi # Fast terminal file manager

      # Shell
      fish # Smart and user-friendly command line shell
    ]
    ++ [
      inputs.helix-master.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

  fonts = {
    packages = with pkgs; [
      jetbrains-mono

      # nerdfonts
      # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
      pkgs.nerd-fonts.symbols-only
    ];
  };
}
