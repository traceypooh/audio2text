# audio2text
docker-based pocketsphinx that takes A/V input file to create text from the audio and extract keywords and entities from the results.

Allows one to, once SETUP is done, run locally on a Mac, network disabled / no cloud, and run speech to text and text analysis on an A/V file.


## PREREQUISTES
Docker (eg:  https://docs.docker.com/docker-for-mac/install/ )

git  (brew or XCode setups have you covered ;-)

## SETUP
```bash
git clone https://github.com/traceypooh/audio2text.git
cd audio2text
docker build -t audio2text .
```

## RUN

```bash
( docker run --rm -i audio2text |tar xf - ) < test.mp3
```
will make (click each to see the results):
* [out.json](out.json) - detailed word/phrase with timings
* [out.txt](out.txt) - transcript of entire audio/video file
* [out.srt](out.srt) - timed transcript of audio/video file
* [out.key](out.key) - keywords extracted from .txt (above)
* [out.plo](out.plo) - Persons, Locations, Organizations (and more) extracted from .txt (above)
