# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
umask 0077

#PS1="\[\033[1;37m\][ \[\033[1;33m\]\u\[\033[1;37m\]@\[\033[1;32m\]\h\[\033[1;37m\]: \[\033[1;34m\]\w\[\033[1;36m\]\[\033[1;37m\]]\$ \[\033[0m\] \[\033];$1\u@\h:\007\]"
#PS1="==>[\W] \\$ "
PS1="\[\033[1;33m\]==>\[\033[0m\] [ \[\033[1;32m\]\h\[\033[0m\]: \[\033[1;34m\]\w\[\033[0m\] ]\$ "
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
   if [ `uname -n` = "enyfac03" ];then
	#export PS1='[\[\033[00;32m\]\u@\h\[\033[00;34m\] \w\[\033[00m\]]\n$(__git_ps1 "(%s) ")\[\033[00;34m\]\\$\[\033[00m\] '
	export PS1='[\[\033[00;32m\]\u@\h\[\033[00;34m\] \w\[\033[00m\]]\n\[\033[00;34m\]\\$\[\033[00m\] '
   fi
export EDITOR=vim
export PAGER=less
export LESS=-r
#export PATH=$HOME/bin:$PATH

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ls='ls -F --color'
alias ll='ls -l'
alias lg='ls -gl'
alias la='ls -a'
#alias meld='/usr/bin/python /usr/share/meld/meld'
alias ssh='ssh -K'
#alias gcc='color-gcc'
#alias c++='color-c++'
#alias g++='color-g++'
#alias cc='color-cc'
#alias ccache='color-ccache'

ilm() # info like man
{
  info $1 --subnodes --output - 2>/dev/null | less
}

#module add use.own
#module add binary/krb5
export PATH=/usr/local/ossh/bin:/usr/local/krb5/bin:$PATH
export KRB5_CONFIG=/usr/local/krb5/etc/krb5.conf

# added by Anaconda3 4.2.0 installer
#export PATH="/home/alofthou/anaconda3/bin:$PATH"
export JAVA_HOME="/usr/java/latest"

# some 21st Century C stuff...
go_libs="-lm"
go_flags="-g -Wall -include allheads.h -O3"
alias go_c="c99 -xc - $go_libs $go_flags"
