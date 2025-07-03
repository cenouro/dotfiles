### Notebook Info

The notebook worked flawless with the following configuration:

* Fedora 42, Gnome 48, Wayland
* Nvidia Driver Version: 575.64
* Kernel parameters: `i8042.dumbkbd i8042.nomux`

The above configuration has been tested and worked very well. There
were no suspension/wake up problems.

The `i8042` kernel parameters may not be necessary, but they do no
harm either from what I can tell. If problems arise, the file
`kernel-args.txt` has a list of `i8042` options that may be further
tested.
