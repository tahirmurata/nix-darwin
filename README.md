<p align="center">
    <img src="https://1.gravatar.com/avatar/a9a8386448882291bd0082d2de054a9fa49a81f00c1c53917a675906e56737ff?size=512" width="160" />
    <h2 align="center">Nix-Darwin</h2>
</p>

<p align="center">Nix for MacBook Air</p>

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

    ```sh
    curl -sSf -L https://install.lix.systems/lix | sh -s -- install
    ```
4. Clone the repository into `~/.dotfiles`:

    ```sh
    git clone https://github.com/tahirmurata/nix-darwin.git ~/nix
    ```
5. Run the `link.sh` script:

    ```sh
    ~/nix/link.sh
    ```
6. Install `nix-darwin`:

    Since darwin-rebuild isn't installed yet, the command uses nix to run darwin-rebuild directly from the nixpkgs repository.
    ```sh
    nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/nix
    ```
7. Setup git with gh:

    ```sh
    gh auth login && gh auth setup-git
    ```

## License
This repository is released into the public domain under the [Unlicense license](UNLICENSE)
