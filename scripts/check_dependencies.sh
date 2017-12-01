#!/bin/sh

error=0

command -v parallel >/dev/null 2>&1 || { echo >&2 "Please install GNU parallel: https://gnu.org/software/parallel/"; error=1; }
command -v ffmpeg >/dev/null 2>&1 || { echo >&2 "Please install ffmpeg: https://ffmpeg.org/"; error=1; }
command -v gm >/dev/null 2>&1 || { echo >&2 "Please install GraphicsMagick: http://graphicsmagick.org/"; error=1; }
command -v ./colors >/dev/null 2>&1 || { echo >&2 "Please place the colors binary in this directory: http://git.2f30.org/colors/"; echo >&2 "=> For video previews, please patch the colors source before building."; error=1; }

exit $error