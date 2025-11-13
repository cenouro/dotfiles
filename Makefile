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

# asdf-nodejs dependencies
PACKAGES += build-essential g++ make python3 python3-pip

# asdf-ruby dependencies
PACKAGES += autoconf build-essential libdb-dev libffi-dev
PACKAGES += libgdbm-dev libgdbm6 libgmp-dev libncurses5-dev
PACKAGES += libreadline6-dev libssl-dev libyaml-dev patch rustc
PACKAGES += uuid-dev zlib1g-dev


# Apps
PACKAGES += mpv


.PHONY : bash git install languagetool mpv
.PHONY : asdf-vm asdf-nodejs asdf-ruby


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


mpv : ${HOME}/.config/mpv/mpv.conf

${HOME}/.config/mpv/mpv.conf : mpv.conf
	mkdir -p $(@D)
	ln -sf $(realpath ./mpv.conf) $@


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


asdf-vm : bash asdf-nodejs asdf-ruby ${HOME}/.local/bin/asdf

${HOME}/.local/bin/asdf : ${HOME}/.local/asdf-v0.18.0-linux-amd64.tar.gz
	tar --extract --gunzip --file=$< --directory=$(@D)

${HOME}/.local/asdf-v0.18.0-linux-amd64.tar.gz :
	wget --quiet --show-progress -O $@ \
	"https://github.com/asdf-vm/asdf/releases/download/v0.18.0/$(@F)"


asdf-nodejs : | ${HOME}/.asdf/plugins/nodejs

${HOME}/.asdf/plugins/nodejs : | ${HOME}/.local/bin/asdf
	$| plugin add nodejs "https://github.com/asdf-vm/asdf-nodejs.git"


asdf-ruby : | ${HOME}/.asdf/plugins/ruby

${HOME}/.asdf/plugins/ruby : | ${HOME}/.local/bin/asdf
	$| plugin add ruby "https://github.com/asdf-vm/asdf-ruby.git"
