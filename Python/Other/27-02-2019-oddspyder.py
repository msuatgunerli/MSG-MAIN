# -*- coding: utf-8 -*-
"""
Created on Wed Feb 27 00:28:39 2019

@author: mehme
"""

from datetime import datetime

odds = [1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59]

rtm = datetime.today().minute
if rtm in odds:
    print ("odd minute.")
    else:
        print('not an odd minute.")