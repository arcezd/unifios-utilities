#!/bin/sh

## This script will add cronjobs from /mnt/data/cronjobs/ or /data/cronjobs/ on boot.
## The path can be personalized by changing the CRONJOBS_DIR variable.
## This script will re-add them on startup.

# Get DataDir location
DATA_DIR="/mnt/data"
case "$(ubnt-device-info firmware || true)" in
    1*)
      DATA_DIR="/mnt/data"
      ;;
    2*)
      DATA_DIR="/data"
      ;;
    3*)
      DATA_DIR="/data"
      ;;
    *)
      echo "ERROR: No persistent storage found." 1>&2
      exit 1
      ;;
  esac

## Adjust this to your needs
$CRONJOBS_DIR="$DATA_DIR/cronjobs"

# Add cronjob files
cp $CRONJOBS_DIR/* /etc/cron.d/
/etc/init.d/crond restart

exit 0
