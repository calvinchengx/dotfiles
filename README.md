dotfiles
========

My miscellaneous dotfiles

Install
=======

./setup.sh

Homebrew backups
=======

```
# backup
brew leaves > ~/work/dotfiles/homebrew-packages.txt
```

```
# restore
cat ~/work/dotfiles/homebrew-packages.txt | xargs brew install
```
