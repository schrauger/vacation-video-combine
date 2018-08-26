#!/bin/bash
# Sets the system modified timestamp of iphone MOV files, based
# on the encoded date within the video metadata.
# Requires 'mediainfo' to be installed.

find . -type f -iname "*.mov" -print0 | while IFS= read -r -d $'\0' filename; do
  creationdate=$(mediainfo "${filename}" | grep "Encoded date" | head -n 1 | cut -d ":" -f2- | xargs)
  echo "Setting system modified time for ${filename} to ${creationdate}"
  touch -d"${creationdate}" "${filename}"
done
