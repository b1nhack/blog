#!/usr/bin/env bash

# Check if config.toml has been modified.
if git diff --cached --name-only | grep -q "config.toml"; then
	echo "config.toml modified. Running subset_font…"

	# Call the subset_font script.
	scripts/subset_font -c config.toml -f static/fonts/JetBrainsMono-Regular.woff2 -o static/

	# Add the generated subset.css file to the commit.
	git add static/custom_subset.css
fi
