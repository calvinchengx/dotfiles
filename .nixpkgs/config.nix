{
  allowUnfree = true;
  allowBroken = true;
  packageOverrides = super: let self = super.pkgs; in
  /*{*/
    /*hs7101 =*/
      /*self.haskell.packages.ghc7101.ghcWithPackages*/
        /*(haskellPackages: with haskellPackages; [*/
          /*cabal-install cabal2nix hdevtools yesod-bin*/
          /*[>ghc-mod is broken for 7101 at this moment<]*/
        /*]);*/
    /*hs784 =*/
      /*self.haskell.packages.ghc784.ghcWithPackages*/
        /*(haskellPackages: with haskellPackages; [*/
          /*cabal-install cabal2nix hdevtools ghc-mod yesod-bin*/
        /*]);*/
  /*};*/

  {
    haskellPackages = super.haskellPackages.override {
      overrides = self: super: {
        ghc-mod = self.callPackage ../../../haskell/ghc-mod {};
      };
    };
  };
}
