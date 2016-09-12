### dotfiles
My dotfiles and essential stuff, such as my `.vim` folder.

#### Submodules
Submodules makes life easier. The following example, adding a vim plugin as a submodule, should give an idea about the entire process and serve as a cheatsheet for myself. Also checkout these references: [Vim Casts] and [Nil's blog post].

[Vim Casts]: http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/
[Nil's blog post]: http://www.nils-haldenwang.de/frameworks-and-tools/git/how-to-ignore-changes-in-git-submodules

##### Add a repo as a submodule
      cd bundle
      git submodule add https://github.com/tpope/vim-pathogen

After this, `git status && git add && git commit` stuff. 

**Note:** Pathogen requires [further instructions,] which are already implemented in `.vimrc`.

[further instructions,]: https://github.com/tpope/vim-pathogen#faq

##### Deploy to new machine
      git clone https://github.com/cenouro/dotfiles
      git submodule update --init

##### Update all submodules
      git clone https://github.com/cenouro/dotfiles
      git submodule foreach git pull origin master

##### Avoid dirty submodules trees
To fix this, edit `.gitmodules`, adding `ignore = dirty` after the submodule url.

#### Oh-My-Zsh configuration
Oh-My-Zsh gitignore file has rules for ignoring the `custom` folder.
[Customizations and themes should go there.] The best way is to implement them on
this repository and then add links to them on the custom folder.

[Customizations and themes should go there.]: https://github.com/robbyrussell/oh-my-zsh#custom-plugins-and-themes

