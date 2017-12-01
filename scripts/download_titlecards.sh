#!/bin/sh

URL="https://imgur.com/a/oPhjP"

download_file() {
	test -f titlecards.zip && return 0
	echo "Downloading title cards. This may take a while... (~150MB)"
	wget "$URL/zip" --quiet --show-progress -O titlecards.zip
}

unzip_files() {
	test -d titlecards && return 0
	echo "Unzipping title cards..."
	unzip titlecards.zip -d titlecards

	# only rename if we just unzipped
	# there's no use renaming already-renamed files, and the zero-padding causes number parsing errors anyway
	rename_files
}

rename_files() {
	echo "Renaming files..."
	find titlecards -type f -name "*.jpg" | while read f; do
		filename="$(basename "$f" | sed "s|['?!&]|_|g")"
		
		episode_number=$(echo "$filename" | sed "s|^\([0-9]*\).*$|\1|g")

		if [[ $episode_number -gt 162 && $episode_number -lt 173 ]]; then
			# for some reason, these titlecards are not named properly
			# so we have to manually fix them
			names=(
				"163 - S06E07 - Food Chain.jpg"
				"164 - S06E08 - Furniture and Meat.jpg"
				"165 - S06E09 - The Prince Who Wanted Everything.jpg"
				"166 - S06E10 - Something Big.jpg"
				"167 - S06E11 - Little Brother.jpg"
				"168 - S06E12 - Ocarina.jpg"
				"169 - S06E13 - Thanks for the Crabapples, Giuseppe.jpg"
				"170 - S06E14 - Princess Day.jpg"
				"171 - S06E15 - Nemesis.jpg"
				"172 - S06E16 - Joshua _ Margaret Investigations.jpg"
			)
			index=$(( episode_number - 163 ))
			mv "$f" "titlecards/${names[$index]}"
			continue
		fi

		# zero-pad episode numbers
		printf -v episode_number "%03d" $episode_number

		name=$(echo "$filename" | sed "s|^\([0-9]*\) - \(.\{7\}\) - \(.*\)\.jpg|\3|g")
		mv "$f" "titlecards/$episode_number - $name.jpg"
	done
}

# download zip of 1080p title cards
# unzip the files into titlecards directory
# rename files to make them easier to process in scripts
download_file && unzip_files