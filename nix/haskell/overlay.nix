nixpkgsSelf: nixpkgsSuper:

let
  inherit (nixpkgsSelf) pkgs;

  ghcVersion = "ghc8107";

  hsPkgs = nixpkgsSuper.haskell.packages.${ghcVersion}.override {
    overrides = self: super: {
      # Override ghcide and some of its dependencies since the versions on
      # Nixpkgs is currently broken.

      stylish-haskell = self.callHackage "stylish-haskell" "1.13.0.0" { };

      # example don't run tests
      # shake = pkgs.haskell.lib.dontCheck (self.callHackage "shake" "0.18.3" {});
    };
  };

in {
  haskell = nixpkgsSuper.haskell // {
    inherit ghcVersion;

    packages = nixpkgsSuper.haskell.packages // { "${ghcVersion}" = hsPkgs; };
  };
}
