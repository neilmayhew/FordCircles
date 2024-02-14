{
  description = "Draw Ford Circles using the Haskell diagrams package";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.simpleFlake {
      inherit self nixpkgs;
      name = "ford-circles";
      overlay = nix/overlay.nix;
      shell = nix/shell.nix;
    };
}
