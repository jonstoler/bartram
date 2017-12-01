#!/bin/sh

test -d titlecards || exit 1

convert_to_png() {
	mkdir titlecards_converted
	echo "Converting titlecards to PNG..."
	find titlecards -type f -name "*.jpg" | parallel -q --bar gm convert "{}" "titlecards_converted/{/.}.png"
}

extract_colors() {
	echo "Extracting titlecard colors..."

	# here, we get 9 colors then delete the darkest one
	# this removes the effect of the black border around all but one title card
	mkdir -p titlecard_colors
	find titlecards_converted -type f -name "*.png" | parallel -q --bar sh -c './colors -n 9 -p < "{}" | sort -r | head -n 8 > "titlecard_colors/{/.}.txt"'
}

test -d titlecards_converted || convert_to_png
test -d titlecard_colors || extract_colors