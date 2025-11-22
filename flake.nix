# Any copyright is dedicated to the Public Domain.
# https://creativecommons.org/publicdomain/zero/1.0/

{
  description = "Nix for MacBook Air";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/main.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.lix.follows = "lix";
    };
  };

  outputs =
    {
      nix-darwin,
      nix-homebrew,
      home-manager,
      lix-module,
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
          lix-module.nixosModules.default

          nix-homebrew.darwinModules.nix-homebrew
          (
            { config, ... }:
            {
              homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
            }
          )

          home-manager.darwinModules.home-manager

          ./modules/settings.nix
          ./modules/system.nix
          ./modules/home.nix
          ./modules/brew.nix
        ];
      };
    };
}
