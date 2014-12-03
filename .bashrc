# .bashrc
# - Files :: Purpose
#   ~/__DEBUG :: be more verbose
#   ~/__NOCUSTOM{.host} :: do not process .custom* files
[ -f ~/__DEBUG ] && DEBUG=1 || DEBUG=0
[ "$DEBUG" = 1 ] && echo "DEBUG: in .bashrc"

# Allow global definitions
hostrc="/etc/bashrc"
if [ -f "$hostrc" ]; then
    [ "$DEBUG" = 1 ] && echo "DEBUG: trying $hostrc"
    . "$hostrc"
fi

# Customize even with common NFS home on the basis of:
#   1 common/generic, 2 per-site, 3 per-host
host="`/bin/uname -n`"
cust=~/__NOCUSTOM
if [ -z "$PS1" ]; then
    [ "$DEBUG" = 1 ] && echo "DEBUG: skip .bashrc.custom*: not interactive"
elif [ ! -f "$ncust" -a ! -f "$ncust"."$host" ]; then
    base=~/.bashrc.custom
    for ext in "" ".site" ".$host"; do
        file="$base""$ext"
        if [ -f "$file" ]; then
            [ "$DEBUG" = 1 ] && echo "DEBUG: trying $file" && . "$file"
        else
            [ "$DEBUG" = 1 ] && echo "DEBUG: no $file"
        fi
    done
else
    [ "$DEBUG" = 1 ] && echo "DEBUG: matched a $cust{,.$host} file"
fi
