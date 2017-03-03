# audio2text
docker-based pocketsphinx that takes A/V input file to create text from the audio

## PREREQUISTES
Docker (eg:  https://docs.docker.com/docker-for-mac/install/ )

## SETUP
```bash
git clone https://github.com/traceypooh/audio2text.git
cd audio2text
docker build -t audio2text .
```

## RUN

```bash
av2text(){ av=$(basename "$1"); docker run --rm -v $(dirname $(realpath "$1")):/app/av audio2text npm test av/"$av"; rm -f "$1".temp.wav; }
av2text myfile.mp3
```

   ( will make:   myfile.mp3.srt   myfile.mp3.json )
