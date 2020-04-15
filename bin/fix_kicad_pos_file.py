#!/usr/bin/env python
# coding:utf8
# read kicad exported position/csv file, fix the head and rotation angle 
# Peng Shulin <trees_peng@163.com>
import os
import re
import sys
import time


FIX_PACKAGES = [
( re.compile('LQFP-[0-9]+_.*'), -90 ),
( re.compile('SOIC-[0-9]+_.*'), -90 ),
( re.compile('SOT-23-6$'), -180 ),
( re.compile('SOT-23$'), -180 ),
( re.compile('SOT-223$'), -180 ),
( re.compile('SOT-223-.*'), -180 ),
]

def fix( posfile ):
    print( 'input: %s'% posfile )
    fin = open(posfile, 'r').readlines()
    fixname = os.path.splitext(posfile)[0] + '_fixed.csv'
    fout = open(fixname, 'w+')
    print( 'output: %s'% fixname )
    head = fin[0].strip().split(',')
    # rename head
    head[head.index('Ref')] = 'Designator'
    head[head.index('Val')] = 'Comment'
    package_idx = head.index('Package')
    head[package_idx] = 'Footprint'
    head[head.index('PosX')] = 'Mid X'
    head[head.index('PosY')] = 'Mid Y'
    rot_idx = head.index('Rot')
    head[rot_idx] = 'rot_kicad'
    head.insert(rot_idx+1, 'Rotation')
    head[head.index('Side')] = 'Layer'
    head.append('Fix_comment')
    fout.write(",".join(head)+'\n')
    # fix line by line
    for l in fin[1:]:
        val = l.strip().split(',')
        val.append('')
        # remove uncessary quotes
        val[0] = val[0].strip('"')
        val[1] = val[1].strip('"')
        val[2] = val[2].strip('"')
        rot_old = float(val[rot_idx])
        rot_new = rot_old
        package = val[package_idx].strip('"')
        #print( package )
        for m, a in FIX_PACKAGES:
            if m.match(package):
                rot_new = (rot_old + a ) % 360.0
                print( 'fix: %s -> %s'% (l.strip(), rot_new) )
                val[-1] = 'Rotated_%s'% a
                break
        val.insert(rot_idx+1, rot_new)
        fout.write(",".join([str(v) for v in val])+'\n')
    fout.close() 
    

if __name__ == '__main__':
    if (len(sys.argv) == 2) and (sys.argv[1].endswith('pos.csv')):
        fix( sys.argv[1] )
    else:
        print( 'Syntax %s <*pos.csv>'% sys.argv[0] )
        sys.exit(1)

