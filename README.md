# Nix config

Lix (like Nix) for MacBook Air

## Usage

1. Install Command Line Tools

   ```sh
   xcode-select --install
   ```

2. Install Rosetta 2

   ```sh
   softwareupdate --install-rosetta --agree-to-license
   ```

3. Install Lix

   Make sure to enable full disk access for your terminal.

   ```sh
   curl -sSf -L https://install.lix.systems/lix | sh -s -- install
   ```

4. Clone the repository into `~/nix`:

   ```sh
   git clone https://gitlab.com/paste/nix.git ~/nix
   ```

5. Install `nix-darwin`:

   Since darwin-rebuild isn't installed yet, the command uses nix to run darwin-rebuild directly from the nixpkgs repository.

   ```sh
   nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/nix
   ```
