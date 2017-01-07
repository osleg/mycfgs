#!/usr/bin/bash
xinput disable `xinput | grep MOSART | grep pointer | awk '{ print $10 }' | awk -F'=' '{print $2}'`
