#!/bin/sh

FILENAME=$1
echo $FILENAME

EXTENSION=$(echo "$FILENAME" | rev | cut -d'.' -f1 | rev)
NEWNAME=$(stat $FILENAME | grep "Modify:" | cut -d' ' -f2- | cut -d'.' -f1 | tr ' ' '_' | tr ':' '-')
mv "$FILENAME" "${NEWNAME}.${EXTENSION}"
