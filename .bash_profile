# .bash_profile
# - Files :: Purpose
#   ~/__DEBUG :: be more verbose
#   ~/__NOCUSTOM{.host} :: do not process .custom* files
[ -f ~/__DEBUG ] && DEBUG=1 || DEBUG=0

_debug() { [ "$DEBUG" = 1 ] && echo "DEBUG: $@"; }
_source()
{
    file="$1"
    if [ -f "$file" ]; then
        _debug "sourcing $file"; . "$file"
    else
        _debug "no $file"
    fi
}

_debug "in .bash_profile"

# Get aliases, functions, etc.
_source ~/.bashrc

# Customize even with common NFS home on the basis of:
#   1 common/generic, 2 per-site, 3 per-host
# could also include:
# - /etc/profile
host="`/bin/uname -n`"
cust=~/__NOCUSTOM
if [ ! -f "$ncust" -a ! -f "$ncust"."$host" ]; then
    base=~/.bash_profile.custom
    for ext in "" ".site" ".$host"; do
        _source "$base""$ext"
    done
else
    _debug "matched a $cust{,.$host} file"
fi
