#!/bin/bash
dart format --fix -l 80 lib
if command -v fvm &> /dev/null
then
    fvm flutter pub run import_sorter:main
else
    flutter pub run import_sorter:main
fi