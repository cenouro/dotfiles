### dotfiles
My dotfiles and essential stuff, such as my `.vim` folder.

#### Submodules
Submodules makes life easier. The following example, adding a vim plugin as a submodule, should give an idea about the entire process and serve as a cheatsheet for myself. Also checkout these references: [Vim Casts] and [Nil's blog post].

[Vim Casts]: http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
[Nil's blog post]: http://www.nils-haldenwang.de/frameworks-and-tools/git/how-to-ignore-changes-in-git-submodules

##### Add a repo as a submodule
      cd bundle
      git submodule add https://github.com/tpope/vim-pathogen

After this, `git status && git add && git commit` stuff. Note: Pathogen requires further instructions. Refer to it's repo's readme.

##### Deploy to new machine
      git clone https://github.com/cenouro/dotfiles
      git submodule update --init
      
##### Update all submodules
      git clone https://github.com/cenouro/dotfiles
      git submodule foreach git pull origin master
      
##### Avoid dirty submodules trees
To fix this, edit `.gitmodules`, adding `ignore = dirty` after the submodule url.
      

