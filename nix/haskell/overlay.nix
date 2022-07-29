nixpkgsSelf: nixpkgsSuper:

let
  inherit (nixpkgsSelf) pkgs;

  ghcVersionNumber = "924";
  ghcVersion = "ghc${ghcVersionNumber}";

  hsPkgs = nixpkgsSuper.haskell.packages.${ghcVersion}.override {
    overrides = self: super: {
      # example use a hackage version of a package
      # stylish-haskell = self.callHackage "stylish-haskell" "1.13.0.0" { };

      # example don't run tests
      # shake = pkgs.haskell.lib.dontCheck (self.callHackage "shake" "0.18.3" {});
    };
  };

  haskell-language-server = nixpkgsSuper.haskell-language-server.override { supportedGhcVersions = [ "${ghcVersionNumber}" ]; };

in {
  haskell = nixpkgsSuper.haskell // {
    inherit ghcVersion;

    packages = nixpkgsSuper.haskell.packages // { "${ghcVersion}" = hsPkgs; };
  };
  haskell-language-server = haskell-language-server;
}
