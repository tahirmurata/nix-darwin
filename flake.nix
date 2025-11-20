{
  description = "Nix for MacBook Air";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nix-darwin,
      nix-homebrew,
      home-manager,
      ...
    }@inputs:
    let
      me = {
        host = "AcacianoMacBook-Air";
        user = "acacia";
        git = {
          name = "Tahir Murata";
          email = "13326175-paste@users.noreply.gitlab.com";
        };
      };
    in
    {
      darwinConfigurations."${me.host}" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs me; };
        modules = [
          nix-homebrew.darwinModules.nix-homebrew
          home-manager.darwinModules.home-manager
          {
            nixpkgs = {
              hostPlatform = "aarch64-darwin";
              config.allowUnfree = true;

              overlays = [
                (final: prev: {
                  inherit (prev.lixPackageSets.stable)
                    nixpkgs-review
                    nix-eval-jobs
                    nix-fast-build
                    colmena
                    ;
                })
              ];
            };
          }

          ./modules/settings.nix
          ./modules/system.nix
          ./modules/home.nix
          ./modules/brew.nix
        ];
      };
    };
}
