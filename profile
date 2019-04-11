#echo '[ running ~/.profile ]'

# Humdrum setup
haskell_path=~/Library/Haskell/bin:/Library/Haskell/bin
HUMDRUM_ROOT=~/src/github/humdrum-tools
humdrum_path=$HUMDRUM_ROOT/humdrum/bin:$HUMDRUM_ROOT/humextra/bin
export HUMDRUM=$HUMDRUM_ROOT/humdrum
export AWK_VER=gawk
export CON=/dev/stderr
export TMPDIR=/tmp

# MATLAB setup
# mldir=/usr/local/matlab7
# mlarch=maci64
#export USER_FALLBACK_LIBRARY_PATH=/lib:/usr/lib:/usr/X11/lib:$mldir/bin/$mlarch:$mldir/sys/os/$mlarch

#this breaks R2012a
#export MATLAB_JAVA=/Library/Java/JavaVirtualMachines/jdk1.7.0_67.jdk/Contents/Home/jre
#export JAVA_HOME=/Library/Java/Home

#more_paths=/usr/local/Wordnet-3.0/bin:~/src/Languages/pakcs/bin
path_prefix=~/bin:~/local/bin:/opt/local/bin:/opt/local/sbin:~/.gem/ruby/2.0.0/bin
manpath_suffix=~/lib/old_humdrum/man:/usr/local/Wordnet-3.0/man

export PATH=$path_prefix:$PATH:$haskell_path:$humdrum_path
export MANPATH=~/man:/opt/local/share/man:$MANPATH:$manpath_suffix
export INFOPATH=/opt/local/share/info:$INFOPATH
export XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS:/opt/local/etc/xdg
export SSH_AUTH_SOCK=~/tmp/ssh/ssh-agent-sock # Use with customised ssh-agent launch agent
export INFOPATH=/opt/local/share/info:$INFOPATH:/usr/local/info
export VICARE_LIBRARY_PATH=/opt/local/lib/ikarus
export PYTHONPATH=~/lib/python2.7/packages
export PYTHONSTARTUP=~/.pythonrc

# This is allows configuration scripts to pick up packages scattered
# over the system. The default pkg-config path seems to be
#
# $ pkg-config --variable pc_path pkg-config
# /opt/local/lib/pkgconfig:/opt/local/share/pkgconfig
#
# ie, MacPorts only. I can add (with current contents):
# - /usr/local/lib/pkgconfig : (jack, smf, swipl)
# - /usr/lib/pkgconfig : (libiodbc + stuff already in MacPorts CHECK CONFLICT)
# - ~/lib/pkgconfig : (my additions)
#
# NB. Put /opt/local/lib/pkgconfig at the head so this is always searched
# first, as it is likely to be the best maintained.
export PKG_CONFIG_PATH=/opt/local/lib/pkgconfig:/usr/local/lib/pkgconfig:~/lib/pkgconfig:/usr/lib/pkgconfig

# OPAM configuration
. ~/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
