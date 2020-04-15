#!/usr/bin/env python
# coding:utf8
# read kicad exported bom/csv file, fix the seperator and footprint
# Peng Shulin <trees_peng@163.com>
import os
import re
import sys
import time


FIX_PACKAGES = [
( re.compile('LQFP-48_.*'), 'LQFP-48' ),
( re.compile('LQFP-64_.*'), 'LQFP-64' ),
( re.compile('LQFP-100_.*'), 'LQFP-100' ),
( re.compile('LQFP-144_.*'), 'LQFP-144' ),
( re.compile('[CR]_0402_.*'), '0402' ),
( re.compile('[CR]_0603_.*'), '0603' ),
( re.compile('[CR]_0805_.*'), '0805' ),
( re.compile('[CR]_1206_.*'), '1206' ),
( re.compile('[CR]_1210_.*'), '1210' ),
( re.compile('[CR]_2512_.*'), '2512' ),
( re.compile('SOT-23-6$'), 'SOT-23-6' ),
( re.compile('SOT-23$'), 'SOT-23' ),
( re.compile('SOT-223$'), 'SOT-223' ),
]

RESISTOR_PATTEN = re.compile('R[0-9]+.*')

def fix( bomfile ):
    print( 'input: %s'% bomfile )
    fin = open(bomfile, 'r').readlines()
    fixname = os.path.splitext(bomfile)[0] + '_fixed.csv'
    fout = open(fixname, 'w+')
    print( 'output: %s'% fixname )
    head = fin[0].strip().split(';')
    # rename head
    for i in range(len(head)):
        head[i] = head[i].strip('"').decode(encoding='utf8')
    print( head )
    head[head.index(u'代号')] = 'Designator'  # 1
    head[head.index(u'封装')] = 'Footprint'  # 2
    head[head.index(u'数量')] = 'Quantity'  # 3
    head[head.index(u'名称')] = 'Comment'  # 4
    head[head.index(u'供应商和REF')] = 'Supplier' # 5
    package_idx = head.index('Footprint')
    head.append('Fix_comment')
    fout.write(",".join(head)+'\n')
    # fix line by line
    for l in fin[1:]:
        val = l.strip().split(';')
        val.append('')
        # remove uncessary quotes
        val[1] = val[1].strip('"').replace(',',' ')
        val[2] = val[2].strip('"').replace(',','_')
        val[4] = val[4].strip('"')
        name = val[1] 
        package = val[2]
        # add 'R' surfix for integer-valued resistors
        if RESISTOR_PATTEN.match(name):
            try:
                int(val[4])  # eg. 100 --> 100R
                val[4] = val[4] + 'R'
                print( 'fix value: %s -> %s'% (name, val[4]) )
            except ValueError:
                pass
        #print( package )
        for m, a in FIX_PACKAGES:
            if m.match(package):
                val[2] = a
                print( 'fix footprint: %s -> %s'% (l.strip(), a) )
                val[-1] = 'renamed_as_%s'% a
                break
        fout.write(",".join([str(v) for v in val])+'\n')
    fout.close() 
    

if __name__ == '__main__':
    if (len(sys.argv) == 2) and (sys.argv[1].endswith('.csv')):
        fix( sys.argv[1] )
    else:
        print( 'Syntax %s <*.csv>'% sys.argv[0] )
        sys.exit(1)

