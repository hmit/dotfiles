from util import redisutils
import pprint, time, datetime, sys, os
from util import base_db
import logging
import json
from util import textutils

rds = redisutils.get_conn()

def counter(listt):
    cnt = dict.fromkeys(range(0, 100), 0)
    for e in listt:
        cnt[int(e*100)] += 1
    return cnt

def plotter(countmap):
    max_f = countmap.values()
    for e, freq in countmap.items():
        print str(e) + '+'+ ''.join(['-'] * (freq))
