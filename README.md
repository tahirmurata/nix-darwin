# Nix config

Lix (like Nix) for MacBook Air

## Installation

1. Install Command Line Tools

   ```sh
   xcode-select --install
   ```

2. Install Rosetta 2

   ```sh
   softwareupdate --install-rosetta --agree-to-license
   ```

3. Install Lix [^1]

   ```sh
   curl -sSf -L https://install.lix.systems/lix | sh -s -- install
   ```

4. Clone the repository into `~/nix`

   ```sh
   git clone https://gitlab.com/paste/nix.git ~/nix
   ```

5. Install `nix-darwin` [^2]

   ```sh
   nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/nix
   ```

## Fish Aliases

| Name | Definition                                        |
| :--: | ------------------------------------------------- |
| `nu` | nix flake update --commit-lock-file --flake ~/nix |
| `nr` | sudo darwin-rebuild switch --flake ~/nix          |
| `lg` | lazygit                                           |

[^1]: When installing make sure you give your terminal full disk access.

[^2]: Since darwin-rebuild isn't installed yet, we use `nix run` to call darwin-rebuild from nixpkgs.
