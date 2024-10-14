#! /usr/bin/env python3

import psutils
import os

if __name__ == '__main__':
    lusers = psutils.users()
    if lusers.len() == 0:
        if os.name == "nt":
            os.system("shutdown /s /t 0")
        elif os.name == "posix":
            os.system("shutdown now")
            # also it should be possible to boot the machine to a spcific time
            # this can archived on posix systems with rtcwake