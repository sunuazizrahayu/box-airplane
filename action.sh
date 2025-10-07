#!/system/bin/sh

MODDIR=${0%/*}
CONFIG_FILE="$MODDIR/config.ini"
log_file="$MODDIR/modpes.log"

# --- Functions ---
update_description() {
  sed -i "s/description=\[.*\]/description=\[$1\]/" "${MODDIR}/module.prop"
}

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$log_file"
}

ui_echo() {
    echo "[$(date '+%H:%M:%S')] $1"
}


# --- Stop old process ---
pkill -f "${MODDIR}/modpes"

# --- Toggle Service State ---
if grep -q "^ENABLED=true" "$CONFIG_FILE"; then
    ui_echo "Disabling service..."
    log_message "Disabling service..."

    # update config value
    sed -i 's/^ENABLED=true/ENABLED=false/' "$CONFIG_FILE"

    # Update module description
    update_description "⛔ Service Disabled"
    log_message "Service has been disabled"
    ui_echo "✅ Service disabled"
else
    ui_echo "Enabling service..."
    log_message "Enabling service..."

    # update config value
    sed -i 's/^ENABLED=false/ENABLED=true/' "$CONFIG_FILE"

    # Start the service
    ui_echo "▶️ Starting service..."
    log_message "Service started"
    $MODDIR/modpes &
    ui_echo "✅ Service is now running"
fi
