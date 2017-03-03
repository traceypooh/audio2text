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
docker run --rm audio2text  <  INPUT-FILENAME | unzip -
```
will make:
* out.json
* out.txt
* out.srt
* out.keys
* out.plo
