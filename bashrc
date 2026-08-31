
if ! [[ ${PATH} =~ "${HOME}/.local/bin" ]]; then
    export PATH="${HOME}/.local/bin:${PATH}"
fi

if [[ -f "${HOME}/.local/bin/asdf" ]]; then
    export PATH="${ASDF_DATA_DIR:-${HOME}/.asdf}/shims:${PATH}"
    . <(asdf completion bash)
fi

if ( command -v fortune &> /dev/null ) && [ -d "${HOME}/.config/fortune" ]
then
    echo ''
    fortune ${HOME}/.config/fortune
    echo ''
fi

# Local Variables:
# mode: sh
# End:
