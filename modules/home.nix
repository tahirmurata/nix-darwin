# Any copyright is dedicated to the Public Domain.
# https://creativecommons.org/publicdomain/zero/1.0/

{
  me,
  pkgs,
  lib,
  ...
}:
{
  home-manager = {
    backupFileExtension = ".bak";
    useGlobalPkgs = true;
    useUserPackages = true;

    users.${me.user} = {
      fonts.fontconfig.enable = true;
      home = {
        username = me.user;
        homeDirectory = "/Users/${me.user}";
        stateVersion = "25.11";

        packages = with pkgs; [
          flyctl
          lazygit

          lldb
          go
          bun

          btop
          fastfetch
          wgo
          age
          ffmpeg
          inetutils

          jetbrains-mono
          nerd-fonts.symbols-only
        ];
      };

      programs.fish = {
        enable = true;
        shellAbbrs = {
          lg = "lazygit";
          nu = "nix flake update --commit-lock-file --flake ~/nix";
          nr = "sudo darwin-rebuild switch --flake ~/nix";
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

            # if test -n "$GHOSTTY_RESOURCES_DIR"
            #     source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
            # end

            fish_config theme choose "Catppuccin Mocha"
          '';

        plugins = [
          {
            name = "arid";
            src = pkgs.fetchFromGitLab {
              owner = "paste";
              repo = "arid";
              rev = "b4d5877cace59f09aced02b6da10799bf8bac17a";
              sha256 = "sha256-OSZOvSjD03LQxXJDrlgyhDgCiLUg4X2RrLd8lXnCr3Q=";
            };
            # src = builtins.path { path = "/home/${me.user}/projects/arid"; };
          }
        ];
      };

      xdg.configFile."fish/themes/Catppuccin Mocha.theme" =
        let
          catppuccinFish = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "fish";
            rev = "6a85af2ff722ad0f9fbc8424ea0a5c454661dfed";
            sha256 = "sha256-Oc0emnIUI4LV7QJLs4B2/FQtCFewRFVp7EDv8GawFsA=";
          };
        in
        {
          source = "${catppuccinFish}/themes/Catppuccin Mocha.theme";
        };

      programs.helix = {
        enable = true;
        defaultEditor = true;

        extraPackages = with pkgs; [
          nixd
          nil
          nixfmt
          gopls
          gotools
          marksman
          prettierd
        ];

        settings = {
          theme = "catppuccin-mocha";

          editor = {
            line-number = "relative";
            cursorline = true;
            completion-replace = true;
            true-color = true;
            color-modes = true;

            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };

            indent-guides.render = true;

            soft-wrap.enable = true;

            lsp.display-inlay-hints = true;

            end-of-line-diagnostics = "hint";
            inline-diagnostics.cursor-line = "warning";
          };

          keys = {
            normal = {
              "ret" = "goto_word";
            };
            insert = {
              "j" = {
                "k" = "normal_mode";
              };
            };
          };
        };

        languages = {
          language = [
            {
              name = "nix";
              auto-format = true;
              formatter.command = lib.getExe pkgs.nixfmt;
            }
            {
              name = "go";
              auto-format = true;
              formatter = {
                command = lib.getExe' pkgs.gotools "goimports";
              };
            }
            {
              name = "markdown";
              auto-format = true;
              formatter = {
                command = lib.getExe pkgs.prettierd;
                args = [
                  ".md"
                ];
              };
              language-servers = [
                "marksman"
              ];
            }
          ];
        };
      };

      xdg.configFile."helix/themes/catppuccin-mocha.toml" =
        let
          catppuccinHelix = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "helix";
            rev = "1f13d5e7c72b064699e2c8761f603e4ddd48db8a";
            sha256 = "sha256-l9R3wMBLf2jofboGIaH39VnpjxP0lbWvhlexdNXq2co=";
          };
        in
        {
          source = "${catppuccinHelix}/themes/default/catppuccin_mocha.toml";
        };

      xdg.configFile."kitty/kitty.conf" = {
        text = ''
          include theme.conf

          font_family      family="Maple Mono" features="+cv02"
          font_size        13.0
          bold_font        auto
          italic_font      auto
          bold_italic_font auto

          tab_bar_min_tabs            1
          tab_bar_edge                bottom
          tab_bar_style               powerline
          tab_powerline_style         slanted
          tab_title_template          {title}{' :{}:'.format(num_windows) if num_windows > 1 else ''\}

          macos_titlebar_color background
          mouse_hide_wait -1.0

          shell /etc/profiles/per-user/acacia/bin/fish --login --interactive
        '';
      };

      xdg.configFile."kitty/theme.conf" =
        let
          catppuccinGhostty = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "kitty";
            rev = "43098316202b84d6a71f71aaf8360f102f4d3f1a";
            sha256 = "sha256-akRkdq8l2opGIg3HZd+Y4eky6WaHgKFQ5+iJMC1bhnQ=";
          };
        in
        {
          source = "${catppuccinGhostty}/themes/mocha.conf";
        };

      xdg.configFile."ghostty/config" = {
        text = ''
          theme = catppuccin_mocha
          shell-integration = none
          mouse-hide-while-typing
          cursor-click-to-move
          auto-update-channel = tip
        '';
      };

      xdg.configFile."ghostty/themes/catppuccin_mocha" =
        let
          catppuccinGhostty = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "ghostty";
            rev = "0eeefa637affe0b5f29d7005cfe4e143c244a781";
            sha256 = "sha256-j0HCakM9R/xxEjWd5A0j8VVlg0vQivjlAYHRW/4OpGU=";
          };
        in
        {
          source = "${catppuccinGhostty}/themes/catppuccin-mocha.conf";
        };

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks = {
          "*".hashKnownHosts = true;
          "*".addKeysToAgent = "yes";
        };
      };

      programs.git = {
        enable = true;

        settings = {
          init.defaultBranch = "main";
          merge.conflictstyle = "zdiff3";
          commit.verbose = true;
          user.name = me.git.name;
          user.email = me.git.email;
        };
      };

      programs.direnv = {
        enable = true;
        nix-direnv = {
          enable = true;
          package = pkgs.nix-direnv;
        };
      };

      programs.lazygit = {
        enable = true;
        settings = {
          gui.language = "en";
        };
      };

      xdg.configFile."lazygit/config.yml" =
        let
          catppuccinLazygit = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "lazygit";
            rev = "c24895902ec2a3cb62b4557f6ecd8e0afeed95d5";
            sha256 = "sha256-4eJEOEfwLBc4EoQ32TpuhXS3QDvQ8FtT7EgpotEKV7o=";
          };
        in
        {
          source = "${catppuccinLazygit}/themes-mergable/mocha/yellow.yml";
        };

      programs.home-manager = {
        enable = true;
      };
    };
  };
}
