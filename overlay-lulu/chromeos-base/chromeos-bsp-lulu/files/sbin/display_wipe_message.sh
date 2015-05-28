#!/bin/sh
#
# Copyright 2015 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.
#
# Script used to show boot message.

FONT_SIZE="60"
FONT_COLOR="Green"

# Temp message file for display_boot_message.
MESSAGE_FILE="$(mktemp --tmpdir)"

on_exit() {
  rm -f "${MESSAGE_FILE}"
}

# Prints usage help for commands usage.
usage_help() {
  echo "Usage: $0 mode [arg ...]

  connect_ac: Message for connecting AC.

  remove_ac: Message for removing AC.

  charging: Message when charging battery.
            Arg #1: the current battery level.
            Arg #2: the minimum battery level to charge.

  discharging: Message when charging battery.
            Arg #1: the current battery level.
            Arg #2: the maximum battery level to discharge.

  cutting_off: Message when running cut off commands.

  cutoff_failed: Message when cut off failed.
"
}

prepare_message() {
  local message="
    <span font=\"Noto Sans UI ${FONT_SIZE}\"
          foreground=\"${FONT_COLOR}\">"

  printf "${message}\n"
  # Append messages with newline.
  for message in "$@"; do
    printf "${message}\n"
  done
  printf "</span>"
}

display_message() {
  prepare_message "$@" >"${MESSAGE_FILE}"
  display_boot_message "show_file" "${MESSAGE_FILE}"
}

mode_connect_ac() {
  (FONT_COLOR="Red" && display_message "Battery level too low" \
                                       "Please connect AC power" \
                                       "电池电量过低" \
                                       "请连接AC电源")
}

mode_remove_ac() {
  (FONT_COLOR="Red" && display_message "Please remove AC power" \
                                       "请移除AC电源")
}

mode_charging() {
  local current_level="$1"
  local min_level="$2"

  display_message "Charging battery to ${min_level}%%..." \
                  "Current level: ${current_level}%%" \
                  "正在充电至${min_level}%%..." \
                  "当前电量：${current_level}%%"
}

mode_discharging() {
  local current_level="$1"
  local max_level="$2"

  display_message "Discharging battery to ${max_level}%%..." \
                  "Current level: ${current_level}%%" \
                  "正在放电至${max_level}%%..." \
                  "当前电量：${current_level}%%"
}

mode_cutting_off() {
  display_message "Cutting off battery" \
                  "Please wait..." \
                  "切断电池电源中" \
                  "请稍候..."
}

mode_cutoff_failed() {
  (FONT_COLOR="Red" && display_message "Battery cut-off failed" \
                                       "Please contact factory team" \
                                       "无法切断电池电源" \
                                       "请联络RD")
}

main() {
  if [ $# -lt 1 ]; then
    usage_help
    exit 1
  fi
  local mode="$1"
  shift

  case "${mode}" in
    "connect_ac" | "remove_ac" | "charging" | "discharging" | "cutting_off" | "cutoff_failed" )
      mode_"${mode}" "$@"
      ;;
    * )
      usage_help
      exit 1
      ;;
  esac
}

trap on_exit EXIT
main "$@"
