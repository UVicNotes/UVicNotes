#!/bin/bash
set -e # exit with nonzero exit code if anything fails

# download and build the theme
wget https://github.com/UVicNotes/NotesTheme/archive/master.zip
unzip master.zip
cd NotesTheme-master/
bower install && npm install
gulp build
mv -v dist/ ../theme/
cd ../
