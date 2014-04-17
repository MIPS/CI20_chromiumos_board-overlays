#!/bin/sh

. /usr/share/misc/shflags

DEFINE_boolean 'enable' ${FLAGS_FALSE} "Enable Touch Device Wakeup" e
DEFINE_boolean 'disable' ${FLAGS_FALSE} "Disable Touch Device Wakeup" d

# Parse command line
FLAGS "$@" || exit 1
eval set -- "${FLAGS_ARGV}"

ret=0
for name in TPAD; do
  if [ ${FLAGS_enable} -eq ${FLAGS_TRUE} ]; then
    grep -q "${name}.*enabled" /proc/acpi/wakeup && continue
    printf "${name}" > /proc/acpi/wakeup
    grep -q "${name}.*enabled" /proc/acpi/wakeup && continue
    ret=1
    continue
  fi

  if [ ${FLAGS_disable} -eq ${FLAGS_TRUE} ]; then
    grep -q "${name}.*disabled" /proc/acpi/wakeup && continue
    printf "${name}" > /proc/acpi/wakeup
    grep -q "${name}.*disabled" /proc/acpi/wakeup && continue
    ret=1
    continue
  fi
done

exit ${ret}
