#!/bin/bash

# Usage: ./decode_mono.sh <exp_dir> <wav_folder>

exp_dir=$1
wav_folder=$2

mono_dir=$exp_dir/mono
graph_dir=$mono_dir/graph
decode_dir=$mono_dir/decode_test
data_dir=data/test_mono
mfcc_dir=mfcc

if [ ! -d "$wav_folder" ]; then
  echo "Error: WAV folder '$wav_folder' not found"
  exit 1
fi

# Prepare data directory
mkdir -p $data_dir
> $data_dir/wav.scp
> $data_dir/utt2spk

utt_count=0
shopt -s nullglob
for wav_path in "$wav_folder"/*.{wav,WAV}; do
  if [ ! -f "$wav_path" ]; then
    continue
  fi
  utt_id="utt$utt_count"
  spk_id="spk$utt_count"
  echo "$utt_id $(realpath "$wav_path")" >> $data_dir/wav.scp
  echo "$utt_id $spk_id" >> $data_dir/utt2spk
  utt_count=$((utt_count+1))
done
shopt -u nullglob

if [ $utt_count -eq 0 ]; then
  echo "No wav files found in $wav_folder"
  exit 1
fi

utils/utt2spk_to_spk2utt.pl $data_dir/utt2spk > $data_dir/spk2utt

# Feature extraction
steps/make_mfcc.sh --nj 1 --cmd run.pl $data_dir exp/make_mfcc/test_mono $mfcc_dir
steps/compute_cmvn_stats.sh $data_dir exp/make_mfcc/test_mono $mfcc_dir

# Decode using mono model
steps/decode.sh --nj 1 --cmd run.pl $graph_dir $data_dir $decode_dir

# Print recognized text
echo "Recognized text:"
for ((i=0; i<utt_count; i++)); do
  utt_id="utt$i"
  echo -n "$utt_id: "
  lattice-best-path --word-symbol-table=$graph_dir/words.txt \
    "ark:gunzip -c $decode_dir/lat.$((i+1)).gz|" ark,t:- \
    | utils/int2sym.pl -f 2- $graph_dir/words.txt \
    | sed "s/^$utt_id //"
done
