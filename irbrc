# fix prompt problems with inf-ruby.el
IRB.conf[:USE_MULTILINE] = false if ENV['INSIDE_EMACS']
IRB.conf[:USE_READLINE]  = false if ENV['INSIDE_EMACS']

# Local Variables:
# mode: ruby
# End:
