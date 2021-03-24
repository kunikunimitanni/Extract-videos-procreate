#!/bin/bash
function concatVideos (){
  fileName=$1
  unzip ${fileName} video/*mp4
  ls -v ./video/segments/|awk '{print "file \047video/segments/" $1 "\047"}' >index.txt;
  ffmpeg -f concat -i index.txt -c copy ${fileName%.*}.mp4
  rm index.txt
  rm -r video
  return 0
}

if [ $# -gt 1 ];
  then
    for x in "$@"; do
      if [ -e $x ];
        then
          concatVideos $x
        else
          echo "$x is not exist."
      fi
    done
  else
    for file in `find . -maxdepth 1 -name '*.procreate'`; do
      concatVideos ${file}
    done
fi




