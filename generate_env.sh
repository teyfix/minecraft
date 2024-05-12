rcon_password=$(dd if=/dev/urandom bs=1 count=24 2>/dev/null | base32 -w 0 | sed 's/=//g')

cat <<EOF >>.env
RCON_HOST="minecraft"
RCON_PORT="25575"
RCON_PASSWORD="$rcon_password"
EOF
