#!/bin/sh

echo "Extracting frames from videos (this may take a while)..."
mkdir -p video_frames
find videos -type f | while read video; do
	bn="$(basename "$video")"
	bn="${bn%.*}"
	test -d "video_frames/$bn" && continue
	mkdir "video_frames/$bn"
	echo "$video"
done | parallel -q --bar ffmpeg -i "{}" -loglevel quiet -filter:v scale=480:-1,fps=2 "video_frames/{/.}/frame_%03d.png"