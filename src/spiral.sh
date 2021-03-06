#!/bin/bash

# Input: Directory of emojis
# Output: A .png of a spiral of all the emojis in the input dir

# NOTE: This assumes that emojis are ~100px high and wide and is most optimal for between 50 and 100 emojis
# NOTE: PLay with END_RADIUS, TRIG_ARG, START_RADIUS for different shaped spirals.

# Note that this assumes the user passes dir names with a trailing /
EMOJI_DIR=$1
IMAGE_OUT_PATH=$2
NUM_EMOJIS_IN_PERIOD=$3

echo "Borrowing emojis from ${EMOJI_DIR}"
echo "And spiraling them into ${IMAGE_OUT_PATH}"

TRIG_ARG="(t/${NUM_EMOJIS_IN_PERIOD})*2*pi"

START_RADIUS='200'
END_RADIUS='(n*20)'
MULTIPLIER="(${END_RADIUS}*(t/n)+${START_RADIUS})"

convert $EMOJI_DIR*.png -set page \
  "+%[fx:${MULTIPLIER}*cos(${TRIG_ARG})]+%[fx:${MULTIPLIER}*sin(${TRIG_ARG})]" \
  -background white \
  -layers merge +repage \
  $IMAGE_OUT_PATH.png
