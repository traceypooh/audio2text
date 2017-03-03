
FROM ubuntu:latest
MAINTAINER tracey@archive.org

RUN apt-get update  &&  apt-get install -y  \
  libsphinxbase-dev sphinxbase-utils pocketsphinx libpocketsphinx-dev \
  git  ffmpeg  npm  nodejs-legacy \
  wget  zsh

RUN git clone https://github.com/OpenNewsLabs/offline_speech_to_text.git /app
WORKDIR /app

# repo above is mac-centric -- swap in our linux pkg binaries installed above
RUN \
  ln -sf /usr/bin/pocketsphinx_batch         pocketsphinx/bin/; \
  ln -sf /usr/bin/pocketsphinx_mdef_convert  pocketsphinx/bin/; \
  ln -sf /usr/bin/pocketsphinx_continuous    pocketsphinx/bin/; \
  ln -sf /usr/bin/ffmpeg                     videogrep_standalone/ffmpeg


RUN npm install subtitles-parser

# make it so the test takes cmd-line arg for filename input
RUN perl -i -pe 's="./norman_door.mp4"=process.argv[2]=' tests/test_main.js


# NLP for extracting entities (people, locations, organizations)
#   http://nlp.stanford.edu/software/CRF-NER.shtml
RUN wget http://nlp.stanford.edu/software/stanford-ner-2016-10-31.zip



RUN (echo -n 'audio2text created: '; date) >> /CREATED


# SRT => transcript
#  perl -ne 'next if m/^\d+\r*$/; next if m/^\d\d:\d\d:\d\d,\d\d\d \-\-> \d\d:\d\d:\d\d,\d\d\d/; print;' *srt |fgrep ' '

# docker run --rm -i audio2text ffmpeg -f mp3 -i - -f wav - < dracula_23_stoker.mp3 > out.wav


# av2text(){ av=$(basename "$1"); docker run --rm -v $(dirname $(realpath "$1")):/app/av audio2text npm test av/"$av"; rm -f "$1".temp.wav; }
# av2text foo.mp3


# default cmd with "docker exec .."
# CMD [ "/petabox/tv/docker/rc.local" ]
