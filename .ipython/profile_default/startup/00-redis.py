import datetime
import cPickle as pickle
import json
import logging
import pprint
import os
import sys
import time

from collections import defaultdict, namedtuple
from util import base_db
from util import redisutils
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
