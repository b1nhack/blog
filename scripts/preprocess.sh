#!/usr/bin/env bash

###################################################################################
# This script is run by git before a commit is made.                              #
# To use it, copy it to .git/hooks/pre-commit and make it executable.             #
# Alternatively, run the following command from the root of the repo:             #
# git config core.hooksPath .githooks                                             #
#                                                                                 #
#                                  FEATURES                                       #
# Updates the "updated" field in the front matter of .md files.                   #
# Runs subset_font if config.toml has been modified.                              #
###################################################################################

# Function to exit the script with an error message.
function error_exit() {
	echo "ERROR: $1" >&2
	exit "${2:-1}"
}

# Check if the script is being run from the root of the repo.
if [[ ! $(git rev-parse --show-toplevel) == $(pwd) ]]; then
	error_exit "This script must be run from the root of the repo."
fi

# Function to extract the date from the front matter.
function extract_date() {
	local file="$1"
	local field="$2"
	grep -m 1 "^$field =" "$file" | sed -e "s/$field = //" -e 's/ *$//'
}

# Check for changes outside of the front matter.
function has_body_changes() {
	local file="$1"
	local in_front_matter=1
	local triple_plus_count=0

	diff_output=$(git diff --unified=999 --cached --output-indicator-new='%' --output-indicator-old='&' "$file")

	while read -r line; do
		if [[ "$line" =~ ^\+\+\+$ ]]; then
			triple_plus_count=$((triple_plus_count + 1))
			if [[ $triple_plus_count -eq 2 ]]; then
				in_front_matter=0
			fi
		elif [[ $in_front_matter -eq 0 ]]; then
			if [[ "$line" =~ ^[\%\&] ]]; then
				return 0
			fi
		fi
	done <<<"$diff_output"
	return 1
}

# Get the modified .md to update the "updated" field in the front matter.
mapfile -t modified_md_files < <(git diff --cached --name-only --diff-filter=M | grep -Ei '\.md$' | grep -v '_index.md$')

# Loop through each modified .md file.
for file in "${modified_md_files[@]}"; do
	# If changes are only in the front matter, skip the file.
	if ! has_body_changes "$file"; then
		continue
	fi

	# Get the last modified date from the filesystem.
	last_modified_date=$(date -r "$file" +'%Y-%m-%d')

	# Extract the "date" field from the front matter.
	date_value=$(extract_date "$file" "date")

	# Skip the file if the last modified date is the same as the "date" field.
	if [[ "$last_modified_date" == "$date_value" ]]; then
		continue
	fi

	# Update the "updated" field with the last modified date.
	# If the "updated" field doesn't exist, create it below the "date" field.
	if ! awk -v date_line="$last_modified_date" 'BEGIN{FS=OFS=" = "; first = 1} {
        if (/^date =/ && first) {
            print; getline;
            if (!/^updated =/) print "updated" OFS date_line;
            first=0;
        }
        if (/^updated =/ && !first) gsub(/[^ ]*$/, date_line, $2);
        print;
    }' "$file" >"${file}.tmp"; then
		error_exit "Failed to process $file with AWK"
	fi

	mv "${file}.tmp" "$file" || error_exit "Failed to overwrite $file with updated content"

	# Stage the changes.
	git add "$file"
done

#########################################################
# Run subset_font if config.toml has been modified.     #
# https://welpo.github.io/tabi/blog/custom-font-subset/ #
#########################################################
if git diff --cached --name-only | grep -q "config.toml"; then
	echo "config.toml modified. Running subset_font…"

	# Call the subset_font script.
	scripts/subset_font -c config.toml -f static/fonts/JetBrainsMono-Regular.woff2 -o static/

	# Add the generated subset.css file to the commit.
	git add static/custom_subset.css
fi
