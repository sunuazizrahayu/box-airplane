#!/system/bin/sh

MODDIR=${0%/*}
CONFIG_FILE="$MODDIR/config.ini"

if grep -q "^ENABLED=true" "$CONFIG_FILE"; then
    sed -i 's/^ENABLED=true/ENABLED=false/' "$CONFIG_FILE"
else
    sed -i 's/^ENABLED=false/ENABLED=true/' "$CONFIG_FILE"
fi

pkill -f "${MODDIR}/modpes"
$MODDIR/modpes &
