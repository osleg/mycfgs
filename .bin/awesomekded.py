import subprocess as sp
from time import sleep

# first we start kded
sleep(2)
r = sp.call('kded4'.split())
sleep(2)
if r.real == 0:
     #kded started, we call for qdbus and unload/load kb module
    sp.call('qdbus org.kde.kded /kded unloadModule keyboard'.split())
    sp.call('qdbus org.kde.kded /kded loadModule keyboard'.split())

