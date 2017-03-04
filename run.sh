#!/bin/bash

# Pipe an A/V file in to have it run (sphinx) speech to text, then entity and keyword extraction.

# We are getting the input file contents from stdin!
# At the end, we will write the many files out into a single tar and dump it to stdout.

(
  # redirect stdin to a temporary file
  cat > out;
  set -ex
  ls -l out;



  # nice way to run docker with stdin / stdout:
  # docker run --rm -i audio2text ffmpeg -i - -f wav - < dracula_23_stoker.mp3 > out.wav


  # run speech-to-text
  npm test out;
  rm -f out out.temp.wav;


  # convert SRT to transcript of words TXT file
  ./srt2txt.sh  out.srt  >  out.txt;


  # extract Person Location and Organization entities using NLP
  java -mx1000m -cp   stanford-ner-2016-10-31/stanford-ner.jar   edu.stanford.nlp.ie.crf.CRFClassifier -inputEncoding utf-8 -outputEncoding utf-8 -loadClassifier stanford-ner-2016-10-31/classifiers/english.all.3class.distsim.crf.ser.gz -outputFormat tabbedEntities -textFile out.txt |cut -f1,2 |egrep '[A-Z]' |sort -k1,1 -k2,2 |egrep '[A-Z]' |uniq -c | sort -k1,1nr -k2,2 |tee out.plo;

  # do generic keywording
  python  spindle-code/keywords/keywords.py  out.txt  >  out.key;

  ls -lh out.*
  set +x
)  1>&2 ; # move any uncaptured-to-output-file  stdout output to stderr

# write all results into a tar single file and dump it to stdout
tar cf - out.*
