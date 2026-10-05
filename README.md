# Nix config

Nix for MacBook Air

## Installation

1. Install Command Line Tools

   ```sh
   xcode-select --install
   ```

2. Install Nix [^1]

   ```sh
   curl --proto '=https' --tlsv1.2 -sSf -L https://artifacts.nixos.org/experimental-installer | \
     sh -s -- install
   ```

3. Clone the repository into `~/nix`

   ```sh
   git clone https://gitlab.com/paste/nix.git ~/nix
   ```

4. Install `nix-darwin` [^2]

   ```sh
   nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/nix
   ```

## Fish Aliases

| Name | Definition                                        |
| :--: | ------------------------------------------------- |
| `nu` | nix flake update --commit-lock-file --flake ~/nix |
| `nr` | sudo darwin-rebuild switch --flake ~/nix          |
| `lg` | lazygit                                           |
| `hx` | helix                                             |

[^1]: When installing make sure you give your terminal full disk access.

[^2]: Since darwin-rebuild isn't installed yet, we use `nix run` to call darwin-rebuild from nixpkgs.
