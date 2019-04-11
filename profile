# samer's bash profile

#echo '[ running ~/.profile ]'

PATH=/opt/local/bin:/opt/local/sbin:$PATH:/usr/local/bin:~/Data/DropBox/bin
MANPATH=/opt/local/share/man:$MANPATH:/Developer/usr/share/man:/usr/local/share/man:/usr/local/man
INFOPATH=/opt/local/share/info:$INFOPATH:/usr/local/info

#PATH=$PATH:/opt/local/lib/postgresql84/bin:~/lib/Argyll_V1.1.0/bin:/usr/local/Wordnet-3.0/bin:~/src/Languages/pakcs/bin
PATH=~/bin:~/local/bin:~/.gem/ruby/2.0.0/bin:/opt/local/lib/postgresql91/bin:/opt/local/lib/mysql55/bin:$PATH
MANPATH=~/man:$MANPATH
#:/usr/local/Wordnet-3.0/man

export XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS:/opt/local/etc/xdg

#export LANG='en_GB.UTF-8'
#source /sw/bin/init.sh

export SSH_AUTH_SOCK=~/tmp/ssh/ssh-agent-sock

mldir=/usr/local/matlab7
mlarch=maci64
##export USER_FALLBACK_LIBRARY_PATH=/lib:/usr/lib:/usr/X11/lib:$mldir/bin/$mlarch:$mldir/sys/os/$mlarch

PATH=$PATH:~/Library/Haskell/bin:/Library/Haskell/bin

HUMDRUM_ROOT=~/src/github/humdrum-tools
PATH=$PATH:$HUMDRUM_ROOT/humdrum/bin:$HUMDRUM_ROOT/humextra/bin
MANPATH=$MANPATH:~/lib/humdrum/man
HUMDRUM=$HUMDRUM_ROOT/humdrum
AWK_VER=gawk
CON=/dev/stderr
TMPDIR=/tmp
export HUMDRUM AWK_VER CON TMPDIR
export PATH MANPATH INFOPATH
export VICARE_LIBRARY_PATH=/opt/local/lib/ikarus
export PYTHONPATH=~/lib/python2.7/packages
export PYTHONSTARTUP=~/.pythonrc

#this breaks R2012a
#export MATLAB_JAVA=/Library/Java/JavaVirtualMachines/jdk1.7.0_67.jdk/Contents/Home/jre
#export JAVA_HOME=/Library/Java/Home


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
# NB. I duplicate /opt/local/lib/pkgconfig at the head so this is always searched 
# first, as it is likely to be the best maintained.
export PKG_CONFIG_PATH=/opt/local/lib/pkgconfig:/usr/local/lib/pkgconfig:~/lib/pkgconfig:/usr/lib/pkgconfig

# OPAM configuration
. ~/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
