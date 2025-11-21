# Nix-Darwin

Nix for MacBook Air

## Usage

1. Install Command Line Tools

   ```sh
   xcode-select --install
   ```

2. Install Rosetta 2

   ```sh
   softwareupdate --install-rosetta --agree-to-license
   ```

3. Install Nix

   Make sure to enable full disk access for your terminal.

   ```sh
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
       sh -s -- install
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

## License

This repository is released into the public domain under the [Unlicense license](UNLICENSE)
