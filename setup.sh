sudo port install vim +huge +python27 +gtk2 +lua
ln -s `pwd`/.bash_profile $HOME/.bash_profile
ln -s `pwd`/.zprofile $HOME/.zprofile
ln -s `pwd`/.gitconfig $HOME/.gitconfig
ln -s `pwd`/.gitignore_global $HOME/.gitignore_global
ln -s `pwd`/.jshintrc $HOME/.jshintrc
ln -s `pwd`/.eslintrc $HOME/.eslintrc
curl https://raw.githubusercontent.com/creationix/nvm/v0.24.1/install.sh | bash
npm install -g eslint babel-eslint eslint-plugin-react
git clone git://github.com/kennethreitz/autoenv.git $HOME/.autoenv

# YouCompleteMe
./$HOME/.vim/bundle/YouCompleteMe/install.sh --clang-completer
ln -s `pwd`/.ycm_extra_conf.py $HOME/.vim/.ycm_extra_conf.py

# Valgrind
ln -s `pwd`/dotfiles/.valgrindrc $HOME/.valgrindrc
ln -s `pwd`/dotfiles/objc.supp $HOME/objc.supp
