#!/bin/sh

# Set the system clock from hardware clock
# If the timestamp is more recent than the current time,
# use the timestamp instead.

# WARNING:      If your hardware clock is not in UTC/GMT, this script
#               must know the local time zone. This information is
#               stored in /etc/localtime. This might be a problem if
#               your /etc/localtime is a symlink to something in
#               /usr/share/zoneinfo AND /usr isn't in the root
#               partition!

HWCLOCKBIN=/sbin/hwclock
ENABLEFALLBACK=1
TIMESTAMPFILE=/etc/timestamp

hwtosys() {
    FALLBACK=1
    if [ -x $HWCLOCKBIN ]
    then
        if [ -z "$TZ" ]
        then
            $HWCLOCKBIN --hctosys
        else
            TZ="$TZ" $HWCLOCKBIN --hctosys
        fi
        FALLBACK=$?
    fi
    if [ $FALLBACK != 0 ]
    then
        timestamptosys
    fi
}

systohw() {
    if [ -x $HWCLOCKBIN ]
    then
        $HWCLOCKBIN --systohc
    fi
    # always store, even when hardware clock is correctly set, we don't know if
    # it is usable on next boot
    systotimestamp
}

timestamptosys() {
    if [ -e $TIMESTAMPFILE -a $ENABLEFALLBACK != 0 ]
    then
        TIMESTAMP=$(/bin/cat $TIMESTAMPFILE)
        SYSTEMDATE=$(/bin/date -u "+%4Y%2m%2d%2H%2M")
        if [ $TIMESTAMP -gt $SYSTEMDATE ]
        then
            /bin/date -u ${TIMESTAMP#????}${TIMESTAMP%????????}
        fi
    fi
}

systotimestamp() {
    if [ $ENABLEFALLBACK != 0 ]
    then
        /bin/date -u +%4Y%2m%2d%2H%2M > $TIMESTAMPFILE
    fi
}

case "$1" in
        --save)
            systohw
            ;;
        *)
            hwtosys
            ;;
esac
