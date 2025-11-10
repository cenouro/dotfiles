
if ! [[ ${PATH} =~ "${HOME}/.local/bin" ]]; then
    export PATH="${HOME}/.local/bin:${PATH}"
fi

# Local Variables:
# mode: sh
# End:
