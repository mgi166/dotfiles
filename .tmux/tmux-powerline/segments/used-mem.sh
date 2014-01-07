#!/usr/bin/env bash
#
# Print memory status.
#
#  Usage:
#    used-mem [Output format]
#
#  Default format:
#    #.1u%(#.1UG/#.1TG)
#
#  Format string:
#    #f : Free memory(%).
#    #u : Used memory(%).
#    #F : Free memory(GB).
#    #U : Used memory(GB).
#    #T : Total memory(GB).
#
#  Example:
#    $ used-mem
#    77.8%(6.2G/8.0G)
#
#    $ used-mem '#f%(#FG/#TG)'
#    22%(2G/8G)
#
#    $ used-mem 'Free: #.2f % (#.3F GB) | Used: #.2u % (#.3U GB) | Total: #.3T GB'
#    Free: 38.32 % (3.065 GB) | Used: 61.68 % (4.933 GB) | Total: 7.998 GB
#
#  About vm_stat:
#    Page size: 4096 bytes
#    http://qz.tsugumi.org/man_vm_stat.html
#    http://d.hatena.ne.jp/zariganitosh/20110617/free_memory
#    https://discussionsjapan.apple.com/thread/10093439?start=0&tstart=0
#    http://support.apple.com/kb/HT1342?viewlocale=ja_JP&locale=ja_JP

DEFAULT_SCALE=${DEFAULT_SCALE:-'.0'}
MAX_SCALE=${MAX_SCALE:-3}


# To round off.
MAX_SCALE=$(($MAX_SCALE + 1))

# This script name.
PROG=$(basename "$0")

# Usage.
USAGE=`cat << __EOF__
Usage:
  $PROG [Output format]
Format string:
  #f : Free memory(%).
  #u : Used memory(%).
  #F : Free memory(GB).
  #U : Used memory(GB).
  #T : Total memory(GB).
__EOF__
`

# Set format.
if [ -z "$1" ]; then
    FORMAT='#.1u%(#.1UG/#.1TG)'
else
    FORMAT=$1
fi

# Cache data.
FREE_MEM=
USED_MEM=
TOTAL_MEM=


# Usage.
exit_usage() {
    echo "$USAGE" 1>&2
    exit 1
}

round_off() {
    local num=$1
    local result

    result=$((($num + 5) / 10))
    result=$(printf "%0${MAX_SCALE}d" $result)
    echo "$result" | sed -e "s/\(.*\)\([0-9]\{$MAX_SCALE\}\)/\1.\2/" -e 's/^\./0./'
}

# Calculate $1/$2(%) to $3 decimal place.
calculate_percent() {
    local num1=$1
    local num2=$2
    local scale=$3
    local result

    if type bc > /dev/null 2>&1; then
        result=$(echo "scale=$MAX_SCALE; 100 * $num1 / $num2" | bc)
    else
        result=$(round_off $(($num1 * 1000 * 10 ** $MAX_SCALE / $num2)))
    fi
    printf "%${scale}f" $result
}

# Convert $1 KB to GB ($2 decimal place).
convert_kb_to_gb() {
    local num=$1
    local scale=$2
    local result

    if type bc > /dev/null 2>&1; then
        result=$(echo "scale=$MAX_SCALE; $num / 1024 / 1024" | bc)
    else
        result=$(round_off $(($num * 10 * 10 ** $MAX_SCALE / 1024 / 1024)))
    fi
    printf "%${scale}f" $result
}

# Calculate used memory(KB) and total memory(KB).
calculate_memory() {
    local free_mem
    local used_mem

    if type vm_stat > /dev/null 2>&1; then
        local vm_stat
        vm_stat=$(vm_stat) || return 1
        local pages_free=$(echo "$vm_stat" | awk '/Pages free/ {print $3}' | tr -d '.')
        local pages_active=$(echo "$vm_stat" | awk '/Pages active/ {print $3}' | tr -d '.')
        local pages_inactive=$(echo "$vm_stat" | awk '/Pages inactive/ {print $3}' | tr -d '.')
        local pages_speculative=$(echo "$vm_stat" | awk '/Pages speculative/ {print $3}' | tr -d '.')
        local pages_wired=$(echo "$vm_stat" | awk '/Pages wired down/ {print $4}' | tr -d '.')

        local free_mem=$((($pages_free + $pages_speculative) * 4096 / 1024))
        local used_mem=$((($pages_active + $pages_inactive + $pages_wired) * 4096 / 1024))
        # Actual memory excluded inactive one.
        #local used_mem=$(($pages_active + $pages_wired))

        if [ -n "$DEBUG" ]; then
            {
                echo "Page size: 4096bytes"
                echo "pages_free: $pages_free pages"
                echo "pages_active: $pages_active pages"
                echo "pages_inactive: $pages_Inactive pages"
                echo "pages_speculative: $pages_speculative pages"
                echo "pages_wired: $pages_wired pages"
                echo
                echo "pages_free: $(($pages_free * 4096 / 1024)) KB"
                echo "pages_active: $(($pages_active * 4096 / 1024)) KB"
                echo "pages_inactive: $(($pages_inactive * 4096 / 1024)) KB"
                echo "pages_speculative: $(($pages_speculative * 4096 / 1024)) KB"
                echo "pages_wired: $(($pages_wired * 4096 / 1024)) KB"
                echo
            } 1>&2
        fi
    elif type free > /dev/null 2>&1; then
        local free
        free=$(free) || return 1
        free_mem=$(echo "$free" | awk '/-\/\+ buffers\/cache/ {print $4}')
        used_mem=$(echo "$free" | awk '/-\/\+ buffers\/cache/ {print $3}')
    else
        echo 'Error: Requires the command free(Linux) or vm_stat(OSX).' 1>&2
        exit 1
    fi

    local total_mem=$(($used_mem + $free_mem))

    if [ -n "$DEBUG" ]; then
        {
            echo "free_mem: $(($free_mem / 1024)) MB"
            echo "used_mem: $(($used_mem / 1024)) MB"
            echo "free_mem(%): $(calculate_percent "$free_mem" "$total_mem" '.3')%"
            echo "used_mem(%): $(calculate_percent "$used_mem" "$total_mem" '.3')%"
            echo "total_mem: $(($total_mem / 1024)) MB"
            echo
        } 1>&2
    fi
    # Caching data.
    FREE_MEM=$free_mem
    USED_MEM=$used_mem
    TOTAL_MEM=$total_mem
}

set_up_format() {
    local sigil=$1
    local format=$2

    local -a list
    list=($(echo "$format" | GREP_OPTIONS= grep -o "#[^#${sigil}]*${sigil}"))

    if [ -n "$DEBUG" ]; then
        {
            echo "sigil=$sigil"
            echo "format=$format"
            echo "list=${list[@]}"
        } 1>&2
    fi

    local item
    local scale
    local num
    for item in "${list[@]}"; do
        scale=$(echo "$item" | sed 's/^#\(.*\).$/\1/')
        if [ -z "$scale" ]; then
            scale=$DEFAULT_SCALE
        fi

        # Check scale.
        if [ $(echo "$scale" | sed 's/.*\.//') -ge $MAX_SCALE ]; then
            echo "Error: Illegal scale: $item" 1>&2
            echo "Specify the value less than ${MAX_SCALE}." 1>&2
            exit 1
        fi

        if [ -n "$DEBUG" ]; then
            {
                echo "item=$item"
                echo "scale=$scale"
            } 1>&2
        fi

        case $sigil in
            f)
                num=$(calculate_percent "$FREE_MEM" "$TOTAL_MEM" "$scale") || return 1
                ;;
            u)
                num=$(calculate_percent "$USED_MEM" "$TOTAL_MEM" "$scale") || return 1
                ;;
            F)
                num=$(convert_kb_to_gb "$FREE_MEM" "$scale") || return 1
                ;;
            U)
                num=$(convert_kb_to_gb "$USED_MEM" "$scale") || return 1
                ;;
            T)
                num=$(convert_kb_to_gb "$TOTAL_MEM" "$scale") || return 1
                ;;
            *)
                echo "Error: Illegal sigil: $sigil" 1>&2
                return 1
                ;;
        esac
        item=$(echo "$item" | sed 's/\./\\./')
        format=$(echo "$format" | sed "s/$item/$num/g")

        if [ -n "$DEBUG" ]; then
            {
                echo "num=$num" 1>&2
                echo "item=$item" 1>&2
                echo "format=$format" 1>&2
            } 1>&2
        fi
    done
    echo "$format"
}

# 元コード
# Main
# main() {
#     calculate_memory || return 1

#     local format=$FORMAT
#     local sigil
#     for sigil in f u F U T; do
#         format=$(set_up_format "$sigil" "$format") || return 1
#     done

#     echo "$format"

#     if [ -n "$DEBUG" ]; then
#         echo '========== ========== ========== =========' 1>&2
#         local debug_format='Free: #.3f % (#.3F GB) | Used: #.3u % (#.3U GB) | Total: #.3T GB'
#         for sigil in f u F U T; do
#             debug_format=$(set_up_format "$sigil" "$debug_format") || return 1
#         done
#         echo "$debug_format" 1>&2
#         echo '========== ========== ========== =========' 1>&2
#     fi
# }
#main || exit_usage

run_segment() {
    calculate_memory || return 1

    local format=$FORMAT
    local sigil
    for sigil in f u F U T; do
        format=$(set_up_format "$sigil" "$format") || return 1
    done

    echo "$format"

    if [ -n "$DEBUG" ]; then
        echo '========== ========== ========== =========' 1>&2
        local debug_format='Free: #.3f % (#.3F GB) | Used: #.3u % (#.3U GB) | Total: #.3T GB'
        for sigil in f u F U T; do
            debug_format=$(set_up_format "$sigil" "$debug_format") || return 1
        done
        echo "$debug_format" 1>&2
        echo '========== ========== ========== =========' 1>&2
    fi
}
