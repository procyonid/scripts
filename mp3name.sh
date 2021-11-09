#!/bin/sh

filepath=$1

songtitle=$(id3info $filepath | grep TIT2 | cut -d ":" -f2-)
songtitle=$(echo $songtitle | tr -d "',.:;!?")
songtitle=$(echo $songtitle | tr '-' '_')
songtitle=$(echo $songtitle | tr '|' '&')
songtitle=$(echo $songtitle | tr ' ' '_')
songtitle=$(echo $songtitle | xargs)
songtitle=${songtitle:-NoTitle}

songartist=$(id3info $filepath | grep TPE1 | cut -d ":" -f2-)
songartist=$(echo $songartist | tr -d "',.:;!?")
songartist=$(echo $songartist | tr '-' '_')
songartist=$(echo $songartist | tr '|' '&')
songartist=$(echo $songartist | tr ' ' '_')
songartist=$(echo $songartist | xargs)
songartist=${songartist:-NoArtist}


songalbum=$(id3info $filepath | grep TALB | cut -d ":" -f2-)
songalbum=$(echo $songalbum | tr -d "',.:;!?")
songalbum=$(echo $songalbum | tr '-' '_')
songalbum=$(echo $songalbum | tr '|' '&')
songalbum=$(echo $songalbum | tr ' ' '_')
songalbum=$(echo $songalbum | xargs)
songalbum=${songalbum:-NoAlbum}

filesha=$(sha256sum $filepath | head -c 12)

new_filename="${songtitle}-${songartist}-${songalbum}-${filesha}.mp3"

echo "$new_filename"

mv $filepath "/home/racc/.personal/Music/$new_filename"
