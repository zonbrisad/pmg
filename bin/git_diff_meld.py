#!/usr/bin/python3

import sys
import os

#print(f"A2: {sys.argv[2]}")
#print(f"A5: {sys.argv[5]}")

os.system('meld "%s" "%s"' % (sys.argv[2], sys.argv[5]))
