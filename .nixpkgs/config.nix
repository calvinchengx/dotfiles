{
  allowUnfree = true;

  packageOverrides = super:
  let self = super.pkgs;
  in
  {
    haskellPackages = super.haskellPackages.override {
      overrides = self: super: {
        ghc-mod = self.callPackage ~/haskell/ghc-mod {};
      };
    };
  };
}
