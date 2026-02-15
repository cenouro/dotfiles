
if ! [[ ${PATH} =~ "${HOME}/.local/bin" ]]; then
    export PATH="${HOME}/.local/bin:${PATH}"
fi

if [[ -f "${HOME}/.local/bin/asdf" ]]; then
    export PATH="${ASDF_DATA_DIR:-${HOME}/.asdf}/shims:${PATH}"
    . <(asdf completion bash)
fi

# Local Variables:
# mode: sh
# End:
