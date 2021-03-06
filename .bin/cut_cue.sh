#!/bin/bash
#Arg 1 is cue file
#Arg 2 is orginal flac file

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "Sintax:"
    echo "cue2flacs.sh cuefile flacFile"
    exit 0
fi

echo "copy a temp cue file ..."
cp "$1" ./tmp.cue

echo "copy a temp flac file ..."
cp "$2" ./tmp.flac

shntool split -f "./tmp.cue" -o 'flac flac --output-name=%f -' -t '%n-%p-%t' "./tmp.flac"

echo "now I will delete the temp cue file ..."
rm ./tmp.cue

echo "now I will delete the temp flac file ..."
rm ./tmp.flac

echo "Do you want to delete the orignal flac ?"
rm -i "$2"