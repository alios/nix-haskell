{
  nixpkgs = builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs.git";
    ref = "haskell-updates";
    rev = "3c0b8e78a9461a680c23a4f3bae0a7d3715bfe01";
  };
}
