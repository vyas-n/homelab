{
  description = "My personal website used to learn and test things.";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    flake-compat.url = "github:edolstra/flake-compat";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs-stable,
      flake-utils,
      ...
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
              nodePackages.prettier-plugin-toml
              ansible-lint

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

            # TODO: fix nushell so that it can be used instead
            shellHook = ''
              exec fish
            '';
          };

        # Outputs
        formatter = pkgs-stable.nixfmt-rfc-style;
      }
    );
}
