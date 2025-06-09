{
  description = "My personal website used to learn and test things.";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    flake-compat.url = "github:edolstra/flake-compat";

    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs =
    { self
    , nixpkgs-stable
    , flake-utils
    , ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs-stable = import nixpkgs-stable {
          inherit system;
          config.allowUnfree = true;
        };

      in
      {
        # Development Environments
        devShells.default =
          with pkgs-stable;
          mkShell {
            packages = [
              # IDE integrations
              nil
              nix
              nixfmt-classic
              rust-analyzer
              nodePackages.prettier
              # nodePackages.prettier-plugin-toml
              ansible-lint
              terraform-ls

              # Dev Tools
              poetry
              terraform
              k0sctl
              trunk-io

              # Doc Generation
              terraform-docs

              # Dev Shell
              nushell
              fish
            ];
          };

        # Outputs
        formatter = pkgs-stable.nixfmt-rfc-style;
      }
    );
}
