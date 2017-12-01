#!/bin/sh

./scripts/check_dependencies.sh && \
./scripts/download_titlecards.sh && \
./scripts/extract_titlecard_colors.sh && \
./scripts/generate_titlecard_previews.sh