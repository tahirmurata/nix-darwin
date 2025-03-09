{
  description = "Nix for MacBook Air";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs =
    inputs@{
      nix-darwin,
      nix-homebrew,
      ...
    }:
    let
      me = {
        username = "acacia";
        hostname = "AcacianoMacBook-Air";
      };
    in
    {
      darwinConfigurations."${me.hostname}" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs me; };
        modules = [
          nix-homebrew.darwinModules.nix-homebrew
          ./modules/settings.nix
          ./modules/system.nix
          ./modules/pkgs.nix
          ./modules/brew.nix
        ];
      };
    };
}
