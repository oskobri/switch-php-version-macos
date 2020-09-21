#!/bin/bash

local last_dir=$(pwd)

brew unlink php@7.1
brew unlink php@7.2
brew unlink php@7.3
brew unlink php
cd $(brew --prefix)/Homebrew/Library/Taps/homebrew/homebrew-core/Formula

if [ $1 = "7.1" ]
then
    git checkout icu4c-64
    brew reinstall ./icu4c.rb
    brew switch icu4c 64.2
    git checkout master
elif [ $1 = "7.2" ]
then
    git checkout icu4c-67
    brew reinstall ./icu4c.rb
    brew switch icu4c 67.1
    git checkout master
elif [ $1 = "7.3" ]
then
    git checkout master
    brew reinstall ./icu4c.rb
    brew switch icu4c 67.1
elif [ $1 = "7.4" ]
then
    git checkout master
    brew reinstall ./icu4c.rb
    brew switch icu4c 67.1
else
    echo "PHP version not supported"
    cd $last_dir
    exit
fi

brew link php@$1 --force
echo 'export PATH="/usr/local/opt/php@'$1'/bin:$PATH"' > ~/.php-version
echo 'export PATH="/usr/local/opt/php@'$1'/sbin:$PATH"' >> ~/.php-version
source ~/.zshrc
cd $last_dir
