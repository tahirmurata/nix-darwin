{
  description = "Nix for MacBook Air";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    lix-module.url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
    lix-module.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      lix-module,
      nix-darwin,
      nix-homebrew,
    }:
    {
      darwinConfigurations."AcacianoMacBook-Air" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          lix-module.nixosModules.default
          {
            # Set user as trusted
            nix.settings.trusted-users = [
              "root"
              "acacia"
            ];

            # Set Git commit hash for darwin-version.
            system.configurationRevision = self.rev or self.dirtyRev or null;

            # Auto upgrade nix package and the daemon service
            services.nix-daemon.enable = true;

            # Necessary for using flakes on this system
            nix.settings.experimental-features = [
              "nix-command"
              "flakes"
            ];

            # Used for backwards compatibility
            system.stateVersion = 5;

            # The platform the configuration will be used on
            nixpkgs.hostPlatform = "aarch64-darwin";

            nixpkgs.config.allowUnfree = true;
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

      darwinPackages = self.darwinConfigurations."AcacianoMacBook-Air".pkgs;
    };
}
