{
  me,
  pkgs,
  lib,
  ...
}:
{
  programs.fish = {
    enable = true;

    shellAbbrs = {
      lg = "lazygit";
      nu = "nix flake update --commit-lock-file --flake";
      nr = "sudo nixos-rebuild switch --flake";
      nsf = "nix-shell --run fish";
    };
    shellInit = # fish
      ''
        set -g fish_greeting
        set -g fish_private_mode 1

        set -g arid_color_pwd      f9e2af
        set -g arid_color_git      bac2de
        set -g arid_color_error    f38ba8
        set -g arid_color_prompt   fab387
        set -g arid_color_duration 9399b2
        set -g arid_color_user     cdd6f4
        set -g arid_color_host     bac2de

        fish_config theme choose "Catppuccin Mocha"
      '';

    plugins = [
      {
        name = "arid";
        src = pkgs.fetchFromGitLab {
          owner = "paste";
          repo = "arid";
          rev = "b4d5877cace59f09aced02b6da10799bf8bac17a";
          # sha256 = "";
        };
        # src = builtins.path { path = "/home/${me.user}/projects/arid"; };
      }
    ];
  };

  environment.etc."xdg/config/fish/themes/Catppuccin Mocha.theme".source = "${
    pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "fish";
      rev = "6a85af2ff722ad0f9fbc8424ea0a5c454661dfed";
      sha256 = "sha256-Oc0emnIUI4LV7QJLs4B2/FQtCFewRFVp7EDv8GawFsA=";
    }
  }/themes/Catppuccin Mocha.theme";
}
