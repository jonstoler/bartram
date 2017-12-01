#!/bin/sh

./scripts/check_dependencies.sh && \
./scripts/extract_video_frames.sh && \
./scripts/extract_video_frame_colors.sh && \
./scripts/generate_video_previews.sh