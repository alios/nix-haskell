nixpkgsSelf: nixpkgsSuper:

let
  inherit (nixpkgsSelf) pkgs;

  ghcVersionNumber = "924";
  ghcVersion = "ghc${ghcVersionNumber}";

  hsPkgs = nixpkgsSuper.haskell.packages.${ghcVersion}.override {
    overrides = self: super: {
      # example use a hackage version of a package
      # stylish-haskell = self.callHackage "stylish-haskell" "1.13.0.0" { };

      # hiedb tests fail with 9.2.4 see https://github.com/wz1000/HieDb/issues/46
      hiedb =
        pkgs.haskell.lib.dontCheck (self.callHackage "hiedb" "0.4.1.0" { });

      # https://github.com/fourmolu/fourmolu/issues/215
      fourmolu =
        pkgs.haskell.lib.dontCheck (self.callHackage "fourmolu" "0.6.0.0" { });
      ormolu =
        pkgs.haskell.lib.dontCheck (self.callHackage "ormolu" "0.5.0.0" { });

    };
  };

  haskell-language-server = nixpkgsSuper.haskell-language-server.override {
    supportedGhcVersions = [ "${ghcVersionNumber}" ];
  };

in {
  haskell = nixpkgsSuper.haskell // {
    inherit ghcVersion;

    packages = nixpkgsSuper.haskell.packages // { "${ghcVersion}" = hsPkgs; };
  };
  haskell-language-server = haskell-language-server;
}
