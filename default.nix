# This uses flake-compat so that all the definitions can be in flake.nix and remain compatible with nix-stable commands
# ref: https://github.com/edolstra/flake-compat

(import
  (
    let
      lock = builtins.fromJSON (builtins.readFile ./flake.lock);
      nodeName = lock.nodes.root.inputs.flake-compat;
    in
    fetchTarball {
      url =
        lock.nodes.${nodeName}.locked.url
          or "https://github.com/edolstra/flake-compat/archive/${lock.nodes.${nodeName}.locked.rev}.tar.gz";
      sha256 = lock.nodes.${nodeName}.locked.narHash;
    }
  )
  { src = ./.; }).defaultNix
