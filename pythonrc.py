import atexit
import readline
import rlcompleter
import os

def persistent_history(histfile='.pyhistory'):
    def save_history():
        readline.write_history_file(histfile)

    print "Using persistent history in %s"%histfile
    readline.parse_and_bind("tab: complete")
    atexit.register(save_history)
    if os.path.exists(histfile):
        readline.read_history_file(histfile)

persistent_history()
