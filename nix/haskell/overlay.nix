nixpkgsSelf: nixpkgsSuper:

let
  inherit (nixpkgsSelf) pkgs;

  ghcVersion = "ghc923";

  hsPkgs = nixpkgsSuper.haskell.packages.${ghcVersion}.override {
    overrides = self: super: {
      # Override ghcide and some of its dependencies since the versions on
      # Nixpkgs is currently broken.

      # stylish-haskell = self.callHackage "stylish-haskell" "1.13.0.0" { };

      # compiler bug on aarch64 causes retry test to fail. should be fixed in ghc 9.2.4
      # see https://github.com/Soostone/retry/issues/78
      # and https://gitlab.haskell.org/ghc/ghc/-/issues/21624
      retry = pkgs.haskell.lib.dontCheck (self.callHackage "retry" "0.9.3.0" {});
    };
  };

in {
  haskell = nixpkgsSuper.haskell // {
    inherit ghcVersion;

    packages = nixpkgsSuper.haskell.packages // { "${ghcVersion}" = hsPkgs; };
  };
}
