# Avoid sub-shells as much as possible since they are a source of
# unexpected behavior.
#
# Some examples:
#
# cd / && echo $(realpath .)          => does NOT print "/"
# echo $(logname)                     => prints an empty string
# basename a.b; echo $(basename a.b)  => prints "a.b", then "a"
#
# The "problem" with the above basename example (and maybe with
# realpath) may be that make seems to have its own implementation of
# these commands and, in such cases, "hijacks" and interprets "$(...)"
# as syntax sugar for them instead of passing it to the shell, which
# would normally run them in a sub-shell. The documentation for the
# built-in basename can be found at:
# https://www.gnu.org/software/make/manual/html_node/File-Name-Functions.html


# Set these variables so that they have pertinent values even if the
# Makefile is ran using sudo.
HOME  = /home/${USER}
USER != logname


PACKAGES := curl git tree wget

# LanguageTool dependency
PACKAGES += default-jre

# Apps
PACKAGES += mpv transmission


.PHONY : bash git install languagetool


install :
	apt update && apt install -y ${PACKAGES}

	snap install amberol
	snap install brave
	snap install chromium
	snap install tagger
	snap install tube-converter

	snap install bitwarden
	snap connect bitwarden:password-manager-service


git : ${HOME}/.config/git/config

${HOME}/.config/git/config :
	mkdir -p $(@D)
	ln -sf $(realpath ./gitconfig) $@


bash : ${HOME}/.bashrc

${HOME}/.bashrc : /etc/skel/.bashrc bashrc
	## Assemble ~/.bashrc
# head and the "-" as argument to cat are used in order to filter out
# the Local Variable list pertinent to Emacs in ./bashrc.
	head --lines=-3 ./bashrc | cat /etc/skel/.bashrc - > $@


${HOME}/.rdbgrc :
	## Don't step into gems when debugging ruby code
	echo "config set skip_path /\/\.asdf\/installs\/ruby\//" > $@


${HOME}/.xprofile : nvidia-xprofile
	## Avoid screen tearing in Xorg
	cat nvidia-xprofile > $@


languagetool : ${HOME}/.local/LanguageTool

${HOME}/.local/LanguageTool : ${HOME}/.local/LanguageTool-6.2.zip
	rm -rf ${HOME}/.local/LanguageTool-6.2/
	unzip -q $< -d $(<D)
	ln -sf ${HOME}/.local/LanguageTool-6.2/ $@

${HOME}/.local/LanguageTool-6.2.zip :
	wget -O $@ "https://languagetool.org/download/LanguageTool-6.2.zip"
