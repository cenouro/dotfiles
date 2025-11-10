# Avoid sub-shells as much as possible since they are a source of
# unexpected behavior.
#
# Some examples:
#
# cd / && echo $(realpath .) => does NOT print "/"
# echo $(logname)            => prints an empty string
#


# Set these variables so that they have pertinent values even if the
# Makefile is ran using sudo.
HOME  = /home/${USER}
USER != logname


.PHONY : git
git : ${HOME}/.config/git/config

${HOME}/.config/git/config :
	mkdir -p $(@D)
	ln -sf $(realpath ./gitconfig) $@


${HOME}/.bashrc : /etc/skel/.bashrc bashrc
	## Assemble ~/.bashrc
	cat $^ > $@


${HOME}/.rdbgrc :
	## Don't step into gems when debugging ruby code
	echo "config set skip_path /\/\.asdf\/installs\/ruby\//" > $@


${HOME}/.xprofile : nvidia-xprofile
	## Avoid screen tearing in Xorg
	cat nvidia-xprofile > $@
