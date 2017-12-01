#!/bin/sh

mkdir -p video_colors
find video_frame_colors -type f -name "*.txt" | while read colors; do
	./colors -n 8 -p -t < "$colors" > "video_colors/$(basename "$colors")"
done

echo "Generating video color previews..."
mkdir -p video_previews
find video_colors -type f -name "*.txt" | while read colors; do
	bn=$(basename "$colors")
	bn=${bn%.*}
	cmd="gm convert -size 440x45 xc:transparent"
	cmd="$cmd -draw \"image over 360,0 80,45 'titlecards/$bn.jpg'\""
	x=0
	while read c; do
		cmd="$cmd -fill '$c' -draw 'rectangle $(( x * 45 )),0 $(( x * 45 + 45 )),45'"
		x=$(( x + 1 ))
	done < "$colors"
	echo "$cmd \"video_previews/$bn.png\""
	unset cmd
done | parallel -q --bar sh -c "{}"