# .bashrc
# - Files :: Purpose
#   ~/__DEBUG :: be more verbose
#   ~/__NOCUSTOM{.host} :: do not process .custom* files
[ -f ~/__DEBUG ] && DEBUG=1 || DEBUG=0
[ "$DEBUG" = 1 ] && echo "DEBUG: in .bashrc"

_source()
{
    file="$1"
    if [ -f "$file" ]; then
        [ "$DEBUG" = 1 ] && echo "DEBUG: sourcing $file" && . "$file"
    else
        [ "$DEBUG" = 1 ] && echo "DEBUG: no $file"
    fi
}

# Get vendor supplied aliases, functions, etc.
_source ~/.bashrc.vendor

# Customize even with common NFS home on the basis of:
#   1 common/generic, 2 per-site, 3 per-host
# could also include:
# - /etc/bashrc /etc/bash.bashrc /etc/bash_completion
host="`/bin/uname -n`"
cust=~/__NOCUSTOM
if [ -z "$PS1" ]; then
    [ "$DEBUG" = 1 ] && echo "DEBUG: skip .bashrc.custom*: not interactive"
elif [ ! -f "$ncust" -a ! -f "$ncust"."$host" ]; then
    base=~/.bashrc.custom
    for ext in "" ".site" ".$host"; do
        _source "$base""$ext"
    done
else
    [ "$DEBUG" = 1 ] && echo "DEBUG: matched a $cust{,.$host} file"
fi
