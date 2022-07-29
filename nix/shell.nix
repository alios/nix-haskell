let
  nixpkgs = import ./nixpkgs.nix { };

  inherit (nixpkgs) pkgs;

  haskell = import ./haskell { inherit pkgs; };

in pkgs.mkShell {
  buildInputs = with pkgs; [
    haskell.cabal-install
    haskell.ghc
    haskell.hlint
    haskellPackages.alex
    haskellPackages.happy
    haskellPackages.structured-haskell-mode
    haskellPackages.haskintex
    haskellPackages.hasktags
    haskell-language-server
    stylish-haskell
    hpack
    cabal2nix
    zlib
  ];

  # Use the libraries from the derivation created by ghcWithHoogle.
  NIX_GHC_LIBDIR = "${haskell.ghc}/lib/ghc-${haskell.ghc.version}";
}
