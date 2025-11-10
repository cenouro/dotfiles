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


${HOME}/.rdbgrc :
	echo "config set skip_path /\/\.asdf\/installs\/ruby\//" > $@

${HOME}/.xprofile : nvidia-xprofile
	cat nvidia-xprofile > $@
