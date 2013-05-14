#!/bin/bash
# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# Quick hack to monitor thermals on Exynos based platforms. Since we only have
# passive cooling, the only thing we can do is limit CPU temp.
#
# TODO: validate readings from hwmon sensors by comparing to each other.
#       We should ignore readings with more than 10C differences from peers.

PROG=`basename $0`
PLATFORM=`mosys platform name`

let debug=0
if [[ "$1x" = '-dx' ]] ; then
    let debug=1
fi

# if PLATFORM is empty, try again
for i in $(seq 5) ; do
    if [[ "${PLATFORM}" != "" ]] ; then
        break;
    fi
    sleep 1
    logger -t "${PROG}" "Unable to get platform name, retry ${i} of 5"
    PLATFORM=`mosys platform name`
done
# Log the platform
logger -t "${PROG}" "Platform ${PLATFORM}"

# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
# 1700000 1600000 1500000 ...
declare -a EXYNOS5_CPU_FREQ=(1700000 1600000 1500000 1400000 1300000 \
    1200000 1100000 1000000 900000 800000 700000 600000 500000 400000 \
    300000 200000)

cpu_tpath="/sys/class/thermal/thermal_zone0"
# TODO(crosbug.com/p/17658) HACK: remove once characterized
if [[ "${PLATFORM}" = "Spring" ]] ; then
    t0=$(( `cat ${cpu_tpath}/trip_point_0_temp` / 1000 - 1 ))
    t1=$(( `cat ${cpu_tpath}/trip_point_1_temp` / 1000 - 1 ))
    declare -a CPU_TEMP_MAP=($t0 $t0 $t0 $t0 $t0 $t0 $t0 $t0 $t0 $t0 $t1)
    declare -a HWMON_TEMP_MAP=($t0 $t0 $t0 $t0 $t0 $t0 $t0 $t0 $t0 $t1)
else
    # CPU temperature threshold we start limiting CPU Freq
    # 63 -> 1.4Ghz, 69 -> 1.1 Ghz, 75 -> 800Mhz
    declare -a CPU_TEMP_MAP=(60 61 62 63 65 67 68 69 71 73 75)
    # 52 -> 1.4Ghz, 60->1.1Ghz, 65->800Mhz
    declare -a HWMON_TEMP_MAP=(49 50 51 52 55 58 60 62 64 65)
fi

declare -a DAISY_CPU_TEMP=("${cpu_tpath}/temp")


#######################################
# Find all hwmon thermal sensors.
#
# Globals:
#   HWMON_TEMP_SENSOR
# Arguments:
#   None
# Returns:
#   None
#######################################
find_hwmon_sensors() {
    local index=0
    local hwmon_dir
    local sensor

    for hwmon_dir in /sys/class/hwmon/hwmon*/device; do
        for sensor in ${hwmon_dir}/temp*_input; do
            HWMON_TEMP_SENSOR[${index}]=${sensor}
            index=$((${index} + 1))
        done
        if [[ "${sensor}" == "" ]] ; then
            logger -t "${PROG}" "WARN: No hwmon temp input @ ${hwmon_dir}"
        fi
    done
    if [[ "${hwmon_dir}" == "" ]] ; then
        logger -t "${PROG}" "WARN: No hwmon devices found."
    fi
}

read_temp() {
    sensor="$1"
    if [[ -r $sensor ]] ; then
        # treat $1 as numeric and convert to C
        local raw
        raw=`cat $sensor 2> /dev/null`
        if [[ -z "$raw" ]] ; then
            return 1
        fi
        let t=$raw/1000

        # valid CPU range is 25 to 125C. Give hwmon sensors more range.
        if  [[ $t -lt 15 || $t -gt 140 ]] ; then
            # do nothing - ignore the reading
            logger -t "$PROG" "ERROR: temp $t out of range"
            return 1
        fi
        return $t
    fi

    logger -t "$PROG" "ERROR: could not read temp from $sensor"
    # sleep so script isn't respawned so quickly and spew
    sleep 10
    exit 1
}

lookup_freq_idx() {
    let t=$1
    shift
    declare -a temp_map=(${*})
    let i=0
    let n=${#temp_map[@]}

    while [[ $i -lt $n ]]
    do
        if [[ $t -le ${temp_map[i]} ]] ; then
            return $i
        fi
        let i+=1
    done

    # we ran off the end of the map. Use slowest speed in that map.
    logger -t "$PROG" "ERROR: temp $t not in temp_map"
    let i=$n-1
    return $i
}

# Thermal loop steps
set_max_cpu_freq() {
    max_freq=$1
    for cpu in /sys/devices/system/cpu/cpu?/cpufreq; do
        echo $max_freq > $cpu/scaling_max_freq
    done
}

# Only update cpu Freq if we need to change.
let last_cpu_freq=0

find_hwmon_sensors

while true; do
    max_cpu_freq=${EXYNOS5_CPU_FREQ[0]}
    # read the list of temp sensors
    for sensor in ${DAISY_CPU_TEMP[*]}
    do
        read_temp $sensor
        let cpu_temp=$?

        lookup_freq_idx $cpu_temp "${CPU_TEMP_MAP[@]}"
        let f=$?
        let cpu_freq=${EXYNOS5_CPU_FREQ[f]}

        if [[ $cpu_freq -gt 0 && $cpu_freq -lt $max_cpu_freq ]] ; then
            max_cpu_freq=$cpu_freq
        fi
    done

    let j=0
    declare -a temps
    for sensor in ${HWMON_TEMP_SENSOR[*]}
    do
        read_temp $sensor
        let temp=$?

        # record temps for (DEBUG and) validation later
        temps[$j]=$temp
        let j+=1
    done

    # TODO validate hwmon sensor readings.
    # we should reject anything that is more than 5C off from all others.
    let max_temp=${temps[0]}
    for k in `seq 1 $j`
    do
        if [[ $max_temp -lt ${temps[k]} ]] ; then
            let max_temp=${temps[k]}
        fi
    done

    lookup_freq_idx $max_temp "${HWMON_TEMP_MAP[@]}"
    let f=$?
    let therm_cpu_freq=${EXYNOS5_CPU_FREQ[f]}

    # we have a valid reading and it's lower than others
    if [[ $therm_cpu_freq -gt 0 && $therm_cpu_freq -lt $max_cpu_freq ]] ; then
        max_cpu_freq=$therm_cpu_freq
    fi

    if [[ debug -gt 0 ]] ; then
        echo `date +"%H:%M:%S"` , \
            `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq`, \
            $max_cpu_freq , $cpu_temp, ${temps[@]}
    fi

    if [[ $last_cpu_freq -ne $max_cpu_freq ]] ; then
        let last_cpu_freq=$max_cpu_freq
        logger -t "$PROG" "Max CPU Freq set to $max_cpu_freq \
(Celsius: $cpu_temp ${temps[@]})"
        set_max_cpu_freq $max_cpu_freq
    fi

    sleep 15
done
