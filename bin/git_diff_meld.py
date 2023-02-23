#!/usr/bin/python3

import sys
import os

os.system('meld "%s" "%s"' % (sys.argv[2], sys.argv[5]))
