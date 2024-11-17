{
  description = "Nix for pastc";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # ⓘ defines the repository for nixpkgs and nix-darwin
    # ! temporary fix for nixpkgs & nix-darwin build fail on :
    #  error: builder for '/nix/store/86459mqpi8i02zf182y96964yajz9v4d-darwin-manual-html.drv' failed with exit code 1;
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # ✏️ This error is caused by the new redirects system that got added to nixos-render-docs yesterday in this commit to nixpkgs. Running the installer with the commit pinned to the commit before the redirects system was introduced, I was able to install nix-darwin successfully. then updated the nixpkgs url before installation.
    # 🌐 https://github.com/LnL7/nix-darwin/issues/1176#issuecomment-2480752009
    nixpkgs.url = "github:NixOS/nixpkgs/8809585e6937d0b07fc066792c8c9abf9c3fe5c4";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
    {
      darwinConfigurations."pastc-darwin" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          {
            # Set Git commit hash for darwin-version.
            system.configurationRevision = self.rev or self.dirtyRev or null;

            # Auto upgrade nix package and the daemon service
            services.nix-daemon.enable = true;

            # Necessary for using flakes on this system
            nix.settings.experimental-features = [ "nix-command" "flakes" ];

            # Used for backwards compatibility
            system.stateVersion = 5;

            # The platform the configuration will be used on
            nixpkgs.hostPlatform = "aarch64-darwin";
          }
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;

              # User owning the Homebrew prefix
              user = "acacia";
            };
          }
          ./system.nix
          ./apps.nix
        ];
      };

      darwinPackages = self.darwinConfigurations."pastc-darwin".pkgs;
    };
}
