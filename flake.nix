{
  description = "Nix for MacBook Air";

  nixConfig = {
    extra-trusted-substituters = [ "https://cache.flox.dev" ];
    extra-trusted-public-keys = [ "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs=" ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    lix-module.url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
    lix-module.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    flox.url = "github:flox/flox/v1.3.12";
  };

  outputs =
    inputs@{
      self,
      lix-module,
      nix-darwin,
      nix-homebrew,
      ...
    }:
    let
      me = {
        username = "acasea";
        hostname = "AcaseanoMacBook-Air";
      };
    in
    {
      darwinConfigurations."${me.hostname}" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs me; };
        modules = [
          lix-module.nixosModules.default
          nix-homebrew.darwinModules.nix-homebrew
          ./modules/settings.nix
          ./modules/system.nix
          ./modules/pkgs.nix
          ./modules/brew.nix
        ];
      };

      darwinPackages = self.darwinConfigurations."${me.hostname}".pkgs;
    };
}
