#!/usr/bin/env python
# adjust samsung nb30 backlight, background daemon
# Peng Shulin <trees_peng@163.com>
import os
import sys
import time
import signal

FIFO = '/dev/shm/set-backlight.fifo'
PID = '/dev/shm/set-backlight.pid'
DEV='/sys/class/backlight/intel_backlight/'
MIN_BRIGHTNESS_PERCENT = 0.005
DELTA_BRIGHTNESS_PERCENT = 0.05

new = actual = int(open(DEV+'actual_brightness', 'r').read())
max_brightness = int(open(DEV+'max_brightness', 'r').read())
min_brightness = int(max_brightness * MIN_BRIGHTNESS_PERCENT)
delta = (max_brightness - min_brightness) * DELTA_BRIGHTNESS_PERCENT

def adjust(n):
    global new, actual
    if n != actual:
        print actual, '->', n
        actual = new = n
        open(DEV+'brightness','w+').write(str(new))


if __name__ == '__main__':
    if os.path.isfile( FIFO ):
        os.remove( FIFO )
    if not os.path.exists( FIFO ):
        os.mkfifo(FIFO)
        os.chmod(FIFO, 0666)
    open( PID, 'w+' ).write( str(os.getpid()) )

    while True:
        try:
            cmd = open('/dev/shm/set-backlight.fifo', 'r').readline().strip()
            if cmd == 'inc':
                adjust(int(min(actual + delta, max_brightness)))
            elif cmd == 'dec':
                adjust(int(max(actual - delta, min_brightness)))
            elif cmd == 'min':
                adjust(min_brightness)
            elif cmd == 'max':
                adjust(max_brightness)
            elif cmd == 'mid':
                adjust((min_brightness + max_brightness)/2)
        except KeyboardInterrupt:
            os.remove( FIFO )
            os.remove( PID )
            sys.exit()
        except:
            pass


