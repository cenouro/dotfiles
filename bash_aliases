# Reference: https://www.jwillikers.com/backup-and-restore-a-gpg-key
alias backup-gpg='gpg -o private.gpg --export-options backup --export-secret-keys'
alias restore-gpg='gpg --import-options restore --import'


# Local Variables:
# mode: sh
# End:
