#!/bin/bash -ex


# av2text(){ av=$(basename "$1"); docker run --rm -v $(dirname $(realpath "$1")):/app/av audio2text av/"$av"; }
# av2text foo.mp3



# nice way to run docker with stdin / stdout:

# docker run --rm -i audio2text ffmpeg -f mp3 -i - -f wav - < dracula_23_stoker.mp3 > out.wav

npm test av/"$1";
rm -f "$1".temp.wav;


./sr2txt.sh  "$1".srt  >  "$1".txt;


java  -mx1000m   -cp   stanford-ner-2016-10-31/stanford-ner.jar   edu.stanford.nlp.ie.crf.CRFClassifier   -inputEncoding utf-8    -outputEncoding utf-8 -loadClassifier stanford-ner-2016-10-31/classifiers/english.all.3class.distsim.crf.ser.gz  -textFile  "$1".txt;
