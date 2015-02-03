#!/usr/bin/env python
# use qiv to monitor a svg image
# use SIGUSR1 signal reload an image is read from fifo(seperated by EOF)
# designed by Shulin Peng <trees_peng@163.com>
import os, sys, tempfile, subprocess, time, signal

def read_svg_from_fifo(i, o):
    contents = []
    while True:
        line = i.readline().strip()
        if line == 'EOF':
            output = open(o, 'w+')
            output.writelines( contents )
            output.close()
            return 
        elif line:
            contents.append( line )


def main(argv=None):
    if argv is None:
        argv = sys.argv

    if len(argv) != 2:
        print >>sys.stderr, "Usage: %s svg_fifo"% argv[0]
        return 1
   
    fifo = open(argv[1], 'r')
    svg = tempfile.mktemp(suffix='.svg', dir='/dev/shm/')
    print( 'svg = %s'% svg )
    # read the first image 
    print 'wait for first svg...'
    read_svg_from_fifo( fifo, svg )
    # then start qiv as subprocess
    qiv = subprocess.Popen(['qiv', '-e', svg])
    print( 'pid = %s'% qiv.pid )
    
    time.sleep(1) 

    try:
        while True:
            print 'reading...'
            read_svg_from_fifo( fifo, svg )
            # update the process
            print 'update...'
            os.kill(qiv.pid, signal.SIGUSR1)
            wait = subprocess.Popen(['inotifywait', '-t', '1', '-e', 'close', svg])
            wait.wait()
            #os.system('inotifywait -t 1 -e close %s >2 2>/dev/null'% svg)
            print 'ok'

    #except KeyboardInterrupt:
    except:
        qiv.kill()
        qiv.wait()
        os.remove( svg )


if __name__ == '__main__':
    sys.exit(main())

