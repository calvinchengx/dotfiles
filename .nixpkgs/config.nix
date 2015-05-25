pkgs: {
  vim = {
    lua = true;
  };
  packageOverrides = pkgs: with pkgs; rec {

    vim-env = pkgs.buildEnv {
      name = "vim-env";
      paths = with vimPlugins; [
        YouCompleteMe
      ];
    };

  };

}
