sudo port install vim +huge +python27 +gtk2 +lua
ln -s ~/work/dotfiles/.bash_profile ~/.bash_profile
ln -s ~/work/dotfiles/.zprofile ~/.zprofile
ln -s ~/work/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/work/dotfiles/.gitignore_global ~/.gitignore_global
ln -s ~/work/dotfiles/.jshintrc ~/.jshintrc
ln -s ~/work/dotfiles/.eslintrc ~/.eslintrc
curl https://raw.githubusercontent.com/creationix/nvm/v0.24.1/install.sh | bash
npm install -g eslint babel-eslint eslint-plugin-react
git clone git://github.com/kennethreitz/autoenv.git ~/.autoenv

# YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
ln -s ~/work/dotfiles/.ycm_extra_conf.py ~/.vim/.ycm_extra_conf.py
