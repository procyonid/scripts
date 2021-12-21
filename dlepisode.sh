#!/bin/sh
inputfile=$1
outfile=$2


i=0
cat $inputfile | while read link; do
    filename="${outfile}.$(printf '%03d' $i)"
    
    downloaded=false
    while [[ "$downloaded" == "false" ]]; do
        youtube-dl -f bestvideo+bestaudio "$link" -o "$filename.tmp.%(ext)s" && downloaded=true
    done

    ls | grep "${filename}.tmp" | xargs -I {} -- ffmpeg -i "{}" -c:a libopus "${filename}.mkv"
    ls | grep "${filename}.tmp" | xargs -I {} -- rm "{}"
    i=$((i+1))
done

ls | grep "$outfile" | xargs -I {} -- echo "file '{}'" >> "${inputfile}_files"
ffmpeg -f concat -i "${inputfile}_files" -c copy $outfile
