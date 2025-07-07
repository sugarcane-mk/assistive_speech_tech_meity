#!/bin/bash

# CONFIGURATION
exp_dir=$1
wav_folder=$2  # Folder containing wav files

model_dir=$exp_dir/DNN_tri_8_2000_aligned_layer3_nodes256
graph_dir=$exp_dir/tri_8_2000/graph
decode_dir=$model_dir/decode_online_test
data_dir=data/test_online
mfcc_dir=mfcc

output_file=results.txt

if [ ! -d "$wav_folder" ]; then
  echo "Error: WAV folder '$wav_folder' not found"
  exit 1
fi

# === Prepare data directory ===
mkdir -p $data_dir

# Clear existing files if any
> $data_dir/wav.scp
> $data_dir/utt2spk
> $output_file

utt_count=0

# Loop over all wav files in folder (supports .wav, case insensitive)
shopt -s nullglob
for wav_path in "$wav_folder"/*.{wav,WAV}; do
  if [ ! -f "$wav_path" ]; then
    continue
  fi

  utt_id="utt$utt_count"
  spk_id="spk$utt_count"

  echo "$utt_id $(realpath "$wav_path")" >> $data_dir/wav.scp
  echo "$utt_id $spk_id" >> $data_dir/utt2spk

  utt_count=$((utt_count + 1))
done
shopt -u nullglob

if [ $utt_count -eq 0 ]; then
  echo "Error: No wav files found in folder $wav_folder"
  exit 1
fi

utils/utt2spk_to_spk2utt.pl $data_dir/utt2spk > $data_dir/spk2utt

# === Extract MFCC ===
steps/make_mfcc.sh --nj 1 --cmd run.pl $data_dir exp/make_mfcc/test_online $mfcc_dir
steps/compute_cmvn_stats.sh $data_dir exp/make_mfcc/test_online $mfcc_dir

# === Decode ===
steps/nnet2/decode.sh --cmd run.pl --nj 1 \
  $graph_dir $data_dir $decode_dir

# === Get best path and write recognized text to results.txt ===
echo "Recognized Text:" >> $output_file

for ((i=0; i<utt_count; i++)); do
  utt_id="utt$i"
  echo -n "$utt_id: " >> $output_file
  lattice-best-path --word-symbol-table=$graph_dir/words.txt \
    "ark:gunzip -c $decode_dir/lat.$((i+1)).gz|" ark,t:- \
    | utils/int2sym.pl -f 2- $graph_dir/words.txt \
    | sed "s/^$utt_id //" >> $output_file
done

echo "Decoding finished. Results saved to $output_file"
