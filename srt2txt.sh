#!/bin/bash -ex

# Take an SRT file, respects UTF-8 encoding, rips out any lead BOM crap, and transforms to single [SPACE] char delimited single line of text
# Outputs to stdout.
# Nicely suitable for NLP.

cat "$1" |perl -ne 'use open ":std", ":encoding(UTF-8)"; next if m/^\d+\r*$/; next if m/^\d\d:\d\d:\d\d,\d\d\d \-\-> \d\d:\d\d:\d\d,\d\d\d/; s/^\x{FEFF}//; s/\r\n/\n/; print;' |tr '\n' ' ' |tr -s ' '
