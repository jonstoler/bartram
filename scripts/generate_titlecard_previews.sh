#!/bin/sh

mkdir -p titlecard_previews

echo "Generating titlecard previews..."
find titlecards -type f -name "*.jpg" | while read titlecard; do
	cmd="gm convert -size 440x45 xc:transparent"
	cmd="$cmd -draw \"image over 0,0 80,45 '$titlecard'\""
	x=0
	bn=$(basename "$titlecard")
	bn=${bn%.*}
	while read color; do
		cmd="$cmd -fill '$color' -draw 'rectangle $(( x * 45 + 80 )),0 $(( x * 45 + 80 + 45 )),45'"
		x=$(( x + 1 ))
	done < "titlecard_colors/$bn.txt"
	echo "$cmd \"titlecard_previews/$bn.png\""
	unset cmd
done | parallel -q --bar sh -c "{}"