#!/bin/bash


declare -A sentence_dict

# Read the file line by line
while read -r line; do
  # Extract the sentence ID (first field) and the sentence (remaining fields)
  sentence_id=$(echo "$line" | cut -d " " -f1)
  sentence=$(echo "$line" | cut -d " " -f2-)
  # Store in the associative array
  sentence_dict["$sentence_id"]="$sentence"
done < text




sed -i 's/%//g' lattice_stats.txt

declare -A stats_dict

# Read the file line by line
while read -r line; do
  # Extract the sentence ID (first field) and the sentence (remaining fields)
  sentence_id=$(echo "$line" | cut -d " " -f1)
  stat=$(echo "$line" | cut -d " " -f2-)
  # Store in the associative array
  stats_dict["$sentence_id"]="$stat"
done < lattice_stats.txt


input_file="output_MONO.txt"

sed -i 's/SIL//g' output_MONO.txt

input_file="output_MONO.txt"
output_file="out.txt"

# Read the file line by line
while IFS= read -r line; do
    # Extract utt_id and sentence IDs
    utt_id=$(echo "$line" | awk '{print $1}')
    sentence_ids=($(echo "$line" | awk '{for(i=2;i<=NF;i++) print $i}'))
    echo $sentence_ids
    # Find the sentence ID with the highest score
    highest_score=0
    chosen_id=""
    for id in "${sentence_ids[@]}"; do
        score="${stats_dict[$id]}"
        if (( $(echo "$score > $highest_score" | bc -l) )); then
            highest_score="$score"
            chosen_id="$id"
        fi
    done

    # Output the chosen sentence ID
    echo "$utt_id $chosen_id" >> "$output_file"
done < "$input_file"


