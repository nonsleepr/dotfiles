# PYTHONSTARTUP
# enable syntax completion
try:
    import readline
except ImportError:
    print('Module readline not available.')
else:
    import rlcompleter
    readline.parse_and_bind('tab: complete')
    readline.parse_and_bind('set editing-mode vi')
