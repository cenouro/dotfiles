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


PACKAGES := git wget
PACKAGES += default-jre


.PHONY : bash git install languagetool


install :
	apt update && apt install -y ${PACKAGES}


git : ${HOME}/.config/git/config

${HOME}/.config/git/config :
	mkdir -p $(@D)
	ln -sf $(realpath ./gitconfig) $@


bash : ${HOME}/.bashrc

${HOME}/.bashrc : /etc/skel/.bashrc bashrc
	## Assemble ~/.bashrc
	cat $^ > $@


${HOME}/.rdbgrc :
	## Don't step into gems when debugging ruby code
	echo "config set skip_path /\/\.asdf\/installs\/ruby\//" > $@


${HOME}/.xprofile : nvidia-xprofile
	## Avoid screen tearing in Xorg
	cat nvidia-xprofile > $@


languagetool : ${HOME}/.local/LanguageTool

${HOME}/.local/LanguageTool : ${HOME}/.local/LanguageTool-6.2.zip
	unzip -q -o $< -d $(<D)
	ln -sf ${HOME}/.local/LanguageTool-6.2 $@

${HOME}/.local/LanguageTool-6.2.zip :
	wget -O $@ "https://languagetool.org/download/LanguageTool-6.2.zip"
