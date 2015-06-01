#!/usr/bin/env python

import os
import sys
import glob

def partSort(pa, pb):
    a, b = pa['partnumber'], pb['partnumber']
    if a > b:
        return 1
    elif a < b:
        return -1
    else:
        return 0
        

def main():
    path = os.path.abspath(sys.argv[0])
    dirname = os.path.dirname(path)
    basename = os.path.basename(dirname)
    configfile = '%s.txt'% basename
    if not os.path.isfile(configfile):
        print '%s not found'% configfile
        sys.exit(1)
    
    # load config
    config = eval(open(configfile, 'r').read())
    TOTALPART = config['info']['totalpart']
    print 'Total part: %s'% TOTALPART
    PARTLIST = config['info']['bookPartList']
    PARTLIST.sort(cmp=partSort)
    pdfdir = 'pdfs'
    if not os.path.isdir(pdfdir):
        os.mkdir(pdfdir)
    # convert:
    for part in PARTLIST:
        partnumber = part['partnumber']
        partid = part['part_id']
        totalpage = part['totalpage']
        dstpdf = os.path.join(pdfdir, '%d.pdf'% partnumber)
        print "Part %s, %s pages"% (partnumber, totalpage)

        if os.path.isfile(dstpdf):
            print 'PDF exist, ignore'
            continue
        # list files 
        os.system( 'ls %s | sort -h > /dev/shm/manhuadao.tmp'% partid )
        files = []
        for l in open('/dev/shm/manhuadao.tmp').readlines():
            files.append(os.path.join(str(partid), l.strip())) 
        #print files
        cmd = 'convert %s %s'% (' '.join(files), dstpdf)
        print cmd
        os.system( cmd )

    # join pdfs
    print 'Join pdfs'
    os.system( 'ls %s | sort -h > /dev/shm/manhuadao.tmp'% pdfdir )
    files = []
    for l in open('/dev/shm/manhuadao.tmp').readlines():
        files.append(os.path.join(pdfdir, l.strip())) 
    cmd = "pdfjoin -o %s.pdf  --papersize '{10.2cm,15.2cm}' --rotateoversize 'false' %s"% (basename, ' '.join(files))
    print cmd
    os.system( cmd )

if __name__ == '__main__':
    main()
