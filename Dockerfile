
FROM ubuntu:latest
MAINTAINER tracey@archive.org

RUN apt-get update  &&  apt-get install -y  \
  libsphinxbase-dev sphinxbase-utils pocketsphinx libpocketsphinx-dev \
  git  ffmpeg  npm  nodejs-legacy \
  wget  zsh  unzip  default-jre

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
RUN wget -q http://nlp.stanford.edu/software/stanford-ner-2016-10-31.zip  &&  unzip stanford-ner-2016-10-31.zip


# generic keyworder code
RUN git clone https://github.com/ox-it/spindle-code.git


COPY *.mp3 *.sh /app/


RUN (echo -n 'audio2text created: '; date) >> /CREATED


# default cmd with "docker exec .."
CMD [ "/app/run.sh" ]
