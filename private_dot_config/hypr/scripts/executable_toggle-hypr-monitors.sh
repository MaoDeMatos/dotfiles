#!/bin/bash
# TODO: Optimization

INTERNAL_MONITOR_NAME="eDP-1"
MONITOR_CONF_PATH="$HOME/.config/caelestia/hypr-user.conf"

CURRENT_MONITOR_CONFIGURATION=$(hyprctl monitors -j)

EXTERNAL_MONITOR_PRESENCE=$(echo "$CURRENT_MONITOR_CONFIGURATION" | jq -r '.[] | select(.name | test("HDMI")) | .name' | head -n 1)

# External monitor is not present.
if [[ -z "$EXTERNAL_MONITOR_PRESENCE" ]]; then
  echo "No external HDMI monitor detected."
  exit 0
fi

# Read contents of monitors configuration file
while IFS= read -r line; do
  # Skip comments and empty lines
  [[ "$line" =~ ^[[:space:]]*# ]] && continue
  [[ "$line" =~ ^[[:space:]]*$ ]] && continue

  # If monitor is internal
  if [[ "$line" =~ ^[[:space:]]*monitor[[:space:]]*=[[:space:]]*$INTERNAL_MONITOR_NAME*(.*) ]]; then
    INTERNAL_MONITOR_PRESENCE=$(echo "$CURRENT_MONITOR_CONFIGURATION" | jq -r ".[] | select(.name == \"$INTERNAL_MONITOR_NAME\") | .name" | head -n 1)

    if [[ -z $INTERNAL_MONITOR_PRESENCE ]]; then
      hyprctl keyword monitor "$INTERNAL_MONITOR_NAME${BASH_REMATCH[1]}"
    else
      echo "Disabling integrated monitor..."
      hyprctl keyword monitor "$INTERNAL_MONITOR_NAME, disable"
    fi
  fi
done < "$MONITOR_CONF_PATH"
