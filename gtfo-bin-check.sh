#!/bin/bash

# GitHub API URL for the directory containing the GTFOBins markdown files
GITHUB_API_URL="https://api.github.com/repos/GTFOBins/GTFOBins.github.io/contents/_gtfobins"

# Output file for the results
OUTPUT_FILE="gtfo-bin-check-results.txt"

# Initialize or clear the output file
echo "gtfo Binaries Check Results" > "$OUTPUT_FILE"
echo "======================" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Fetch the list of .md files from the GitHub repository
echo "Fetching the list of binaries from GitHub..."
response=$(curl -s "$GITHUB_API_URL")

# Check if the response contains any files
if [[ $(echo "$response" | jq '. | length') -eq 0 ]]; then
    echo "No binaries found in the GitHub repository." >> "$OUTPUT_FILE"
    echo "Exiting script." 
    exit 1
fi

# Create an array to hold binary names
binaries=()

# Loop through each markdown file retrieved from GitHub
while IFS= read -r file; do
    # Get the binary name by stripping the .md extension
    binary_name=$(basename "$file" .md)
    
    # Add the binary name to the array
    binaries+=("$binary_name")
done < <(echo "$response" | jq -r '.[] | select(.name | endswith(".md")) | .name')

# Count total binaries
total_binaries=${#binaries[@]}

# Inform the user about the total binaries found
echo "Total binaries found: $total_binaries"

# Check if binaries are installed and write results to the output file
for binary_name in "${binaries[@]}"; do
    if command -v "$binary_name" &> /dev/null; then
        echo "✔ Binary '$binary_name' is installed." >> "$OUTPUT_FILE"
    else
        echo "✖ Binary '$binary_name' is NOT installed." >> "$OUTPUT_FILE"
    fi
done

# Append the total binaries checked to the output file
echo "" >> "$OUTPUT_FILE"
echo "Total binaries checked: $total_binaries" >> "$OUTPUT_FILE"

# Display a summary of results
echo "Summary of results:" >> "$OUTPUT_FILE"
echo "--------------------" >> "$OUTPUT_FILE"
installed_count=$(grep -c '✔' "$OUTPUT_FILE")
missing_count=$(grep -c '✖' "$OUTPUT_FILE")
echo "Installed binaries: $installed_count" >> "$OUTPUT_FILE"
echo "Missing binaries: $missing_count" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Display completion message
echo "Binaries check results have been saved to $OUTPUT_FILE."
echo "You can view the detailed results in $OUTPUT_FILE."
