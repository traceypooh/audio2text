# audio2text
docker-based pocketsphinx that takes A/V input file to create text from the audio

## PREREQUISTES
Docker (eg:  https://docs.docker.com/docker-for-mac/install/ )

## SETUP
cd [to directory you have cloned this repo to]

docker build -t audio2text .

## RUN
av2text(){ av=$(basename "$1"); docker run --rm -v $(dirname $(realpath "$1")):/app/av audio2text npm test av/"$av"; rm -f "$1".temp.wav; }

av2text myfile.mp3
   ( will make:   myfile.mp3.srt   myfile.mp3.json )
