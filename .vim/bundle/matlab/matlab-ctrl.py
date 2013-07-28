#!/usr/bin/python2

from subprocess import call
from subprocess import check_output
import sys

wcmd = ["xdotool","search","--name","MatlabT"]
w = check_output(wcmd)
w = w.replace('\n','')

if len(sys.argv) > 1:
  s = sys.argv[1]

cmd = ["xdotool","key","--window",w]

for i in range(len(s)):
  cmd.append(s[i])

cmd.append("Return")

call(cmd)
