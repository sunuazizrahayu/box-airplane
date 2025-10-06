#!/system/bin/sh

MODDIR=${0%/*}

until [ "$(getprop sys.boot_completed)" = "1" ]; do sleep 1; done
until [[ -n $(dumpsys telephony.registry | grep "mDataConnectionState=2" | awk '{print $NF}') ]]; do sleep 1; done
$MODDIR/modpes &
