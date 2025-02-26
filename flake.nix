{
  description = "My personal website used to learn and test things.";

  inputs = {
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";

    flake-compat.url = "github:edolstra/flake-compat";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs-stable, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs-stable = import nixpkgs-stable { inherit system; };

      in {
        # Tests
        # checks = {};

        # Packages / Artifacts
        # packages.default = personal-site;
        # packages.node-modules = node-modules;
        # packages.bulma = bulma;

        # Executable scripts
        # apps.deploy = flake-utils.lib.mkApp {
        #   drv = pkgs-stable.writeShellScriptBin "deploy" ''
        #     ${pkgs-stable.wrangler}/bin/wrangler pages deploy --project-name=vyas-n --branch $GITHUB_REF_NAME ${personal-site}/
        #   '';
        # };
        # apps.default = flake-utils.lib.mkApp {
        #   drv = pkgs-stable.writeShellScriptBin "serve-app" ''
        #     ${pkgs-stable.trunk}/bin/trunk serve ${personal-site}
        #   '';
        # };
        # apps.debug = flake-utils.lib.mkApp {
        #   drv = pkgs-stable.writeShellScriptBin "debug" ''
        #     tree ${bulma}
        #   '';
        # };

        # Development Environments
        devShells.default = with pkgs-stable;
          mkShell {
            packages = [
              # IDE integrations
              nil
              nix
              nixfmt-classic
              rust-analyzer
              nodePackages.prettier

              # Dev Tools
              nushell
              nushellPlugins.formats
            ];
            shellHook = ''
              exec nu
            '';
          };
      });
}
