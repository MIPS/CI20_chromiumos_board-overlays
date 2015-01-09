#!/bin/sh

# This set the persist flag for the usb camera, and thus forces a reset
# resume if the usb camera doesn't respond after autosuspend/resume.
# If we don't set the persist flag, it is unset on default by the driver.

echo 1 > "/sys/${DEVPATH}/power/persist" || \
  logger "uvc-quirks: could not set persist flag"
