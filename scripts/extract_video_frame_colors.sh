#!/bin/sh

echo "Extracting colors from video frames..."
mkdir -p video_frame_colors
find video_frames -type d -depth 1 | while read d; do
	bn="$(basename "$d")"
	bn="${bn%.*}"
	test -f "video_frame_colors/$bn.txt" && continue
	find "$d" -type f -name "*.png" | parallel -q --bar sh -c "./colors -n 8 -p < \"{}\" | sort -r >> \"video_frame_colors/$bn.txt\""
done