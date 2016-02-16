#!/usr/bin/env python

import string

from evdev import InputDevice
from select import select
from subprocess import Popen
import os

#dev = InputDevice('/dev/input/by-id/usb-HID_OMNIKEY_5127_CK_01010053423438303000835748112531-event-kbd')
dev = InputDevice('/dev/input/by-id/usb-0430_0005-event-kbd')

# base on keyboard responses
# a-z 0-9 RET ESC DEL TAB SPACE - = [ ] \ # ; '
map = {
    16: "1.mp3",
    17: "2.mp3",
    18: "3.mp3",
    19: "4.mp3",
    20: "5.mp3",
    21: "6.mp3",
    22: "7.mp3",
    23: "8.mp3",
    24: "9.mp3",
    25: "10.mp3",
}
sampleDir = "/home/pi/sample-numbers/"
#sampleDir = "/home/pi/sample/"

while True:
    r,w,x = select([dev], [], [])
    for event in dev.read():
        if event.type==1 and event.value==1:
            print( event.code )

            if event.code in map.keys():
                samplePath = sampleDir + map[event.code]
                Popen("/usr/bin/mpg321 " + samplePath, shell=True, stdin=None, stdout=os.devnull, stderr=None, close_fds=True)
