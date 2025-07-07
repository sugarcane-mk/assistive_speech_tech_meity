# Assistive Speech Technologies

This repository provides **Automatic Speech Recognition (ASR) and Text-to-Speech (TTS)** models developed by the Speech Lab, Department of Electronics and Communication Engineering, SSN College of Engineering, Chennai. These models were created as part of the Assistive Technologies module within the Bashini: National Language Translation Mission (NLTM) – Speech Technologies in Indian Languages Project, funded by the Ministry of Electronics and Information Technology (MeitY), Government of India.

The models aim to support speech processing applications for Indian languages and are intended for research and assistive technology development.
This repo contains:
- [Pre-trained ASR model_Individual_speaker_6](https://github.com/SpeechLabSSN/assistive_speech_tech_meity/tree/main/models/asr/kaldi_dysarthria)
- [ASR mild and moderate](https://github.com/SpeechLabSSN/assistive_speech_tech_meity/tree/main/class-wise%20ASR%20models)
- [TTS models HTS](models/tts/hts)
- [TTS models Taco2](models/tts/taco2)
- Script for testing ASR - [decode_mono.sh](https://github.com/SpeechLabSSN/assistive_speech_tech_meity/blob/main/models/asr/kaldi_dysarthria/decode_mono.sh) , [decode_tri.sh](https://github.com/SpeechLabSSN/assistive_speech_tech_meity/blob/main/class-wise%20ASR%20models/decode_tri.sh)

To gain access to the data, please send an request [here](https://drive.google.com/file/d/1JiicZTT2X6Q_WQVltMrBwnnSyCHeL5n6/view?usp=drive_link) with details of how you wish to use the data.

# Usage instructions
## Pre-requisites
The pre-trained models were trained using an **older version of Kaldi**.
To avoid conflicts with your current Kaldi installation, use the provided old Kaldi files and dependencies as mentioned below.
 1. `prerequisites.zip`
     - Contains the shared libraries and dependencies that should be placed in /usr/lib on your system.
     - This ensures that any binary or shared libs used by the old Kaldi will work correctly.

 2.  Old versions of:

       - `steps` directory
       -   `utils` directory
       -   `kaldi/src` directory
       -   `kaldi/tools` directory
       -   `path.sh` script (Kaldi root directory has to be updated)

These are all packaged inside the assistive_speech_tech_meity.zip.

---
## Setup & Usage Flow (with steps and utils inside cwd/)

 ###   Extract assistive_speech_tech_meity.zip
       Unzip to your working directory. You will have:
```
kaldi/
  egs/
    cwd/
      steps/       ← old steps here  
      utils/       ← old utils here  
      path.sh      ← old path.sh file  
  src/           ← old kaldi/src  
  tools/         ← old kaldi/tools  
prerequisites.zip  ← dependencies to copy to /usr/lib
```
### Install Prerequisites
```
sudo unzip prerequisites.zip -d /usr/lib
```
### Set Kaldi Root & Environment
In cwd/path.sh, set KALDI_ROOT to the Kaldi root (e.g. two levels up) using relative paths.
Then source it before running any scripts:
```
source path.sh
```
### Build Kaldi Binaries
 From kaldi/src:
```
cd ../../src
./configure
make clean -j $(nproc)
make -j $(nproc)
```
> Note: All training and decoding scripts inside the cwd/ directory must use the local steps/ and utils/ directories provided in the same folder.
Do not use the global or system-wide Kaldi versions of these directories.
Replace any existing steps/ and utils/ folders with the versions included in the assistive_speech_tech_meity.zip package to ensure compatibility with the older Kaldi setup used to train and test the models.

![image](https://github.com/user-attachments/assets/c4ffe85d-772b-44e1-a578-7562f73be6db)
---

## Testing Class-wise ASR
```
cd kaldi/egs
git clone --no-checkout https://github.com/SpeechLabSSN/assistive_speech_tech_meity.git
cd assistive_speech_tech_meity
git sparse-checkout init --cone
git sparse-checkout set "class-wise ASR models"
git checkout
```
```
cd class-wise ASR models
unzip *mild -d test_data_mild 
unzip *moderate -d test_data_moderate
```
```
# usage
# decode_tri.sh <exp_dir> <path_to_test_folder>
# Example : To test with a mild dysarthric speaker data, use the following syntax
decode_tri.sh exp_FG_mild ./test_data_mild/FSI
```
--- 
## Testing individual speaker's ASR model
```
cd kaldi/egs
git clone --no-checkout https://github.com/SpeechLabSSN/assistive_speech_tech_meity.git
cd assistive_speech_tech_meity
git sparse-checkout init --cone
git sparse-checkout set "models/asr/kaldi_dysarthria"
git checkout
```
```
cd models/asr/kaldi_dysarthria
unzip *mild -d test_data_mild 
unzip *moderate -d test_data_moderate
```
```
# usage
# decode_mono.sh <exp_dir> <path_to_test_folder>
# Example : To test with a mild dysarthric speaker data, use the following syntax
decode_mono.sh exp_FDH ./test_data_moderate/FDH
```
--- 
# Information on the Testing and Training Datasets

## SSN-TDSC: Tamil Dysarthric Speech Corpus

Ours is the first disordered speech database (SSN-TDSC) in the Indian language. This database is collected in the language Tamil. The dysarthric speakers are identified across various severity levels. Sentences are formulated based on the inputs from speech and language therapists, caretakers, teachers from National Institute for empowerment for people with multiple disabilities. Around 300 phonetically balanced conversational sentences in various domains with 10 repetitions each are collected. The speakers are asked to repeat the sentences after the trainer.

---

## Transfer-learning Based ASR

### Training

The speaker-independent normal speaker’s source model is trained with 10 normal speaker’s speech data who have uttered 365 utterances each. While training the normal speaker’s source model the vocabulary of the application-based dysarthric speech is included in the lexicon for training. 

13-dimensional Mel-frequency cepstral coefficients (MFCC’s) are extracted and transformed into a 40-dimensional vector and a speaker adaptive training using GMM-HMM is employed based on feature-space maximum likelihood linear regression. 

With the trained HMM, a TDNN-F network incorporating CNNs is trained for the normal speakers. The trained normal speaker model is the source model for the target dysarthric speaker. The augmented dysarthric speech data is then trained using 3-layered CNN with three epochs, at a batch size of 16 and 0.0005 learning rate using L2 regularization. The DNN parameters are transformed from the source model to the target model to train the speech of the target dysarthric speaker.

### Testing

With the trained dysarthric speaker model, testing of the dysarthric speech recognition system is performed using the augmented test data which consists of 175 sentences (5 original test sentences * 35 augmented sentences).

---

## HTS-Based Speaker Adaptive TTS Systems

### Experimental Setup

- Training data – 4 normal speakers’ native Tamil data of approximately 1 hour duration each (Aarthi, Rajiv, Sherlin & Ramya)  
- Adaptation data – dysarthric speakers’ data (for all mild and moderate speakers of TDSC dataset – 365 sentences)  
- Number of dysarthric speakers: Mild speaker – 7 & Moderate speaker – 10  
- For each dysarthric speaker, a TTS is developed with them as an adapted speaker. Totally, we have 17 HTS-based adaptation TTS. In total 1000 utterances (including 365 from SSN TDSC) are synthesized for each dysarthric speaker (1000 x 17 utterances).

---

## Tacotron-Based Speaker Adaptive TTS Systems

### Experimental Setup

- Training data - Approximately 11 hours of data from 40 native Tamil speakers (approx. 5.5 hrs of data from 15 female speakers and another 5.5 hrs from 25 male speakers)  
- Fine-tuning - 325 utterances of the SSN TDSC from the required dysarthric speaker  
- In total 1000 utterances (including 365 from SSN TDSC) are synthesized for each dysarthric speaker (1000 x 17 utterances).

# Benchmarking Metrics for Dysarthric Speech ASR and TTS Systems

This document summarizes the performance metrics used to evaluate Automatic Speech Recognition (ASR) and Text-to-Speech (TTS) systems developed for dysarthric speakers. Evaluation metrics include **Word Error Rate (WER)** for ASR and **Mean Opinion Score (MOS)** for TTS.

---

##  ASR Performance Metrics

**Metric:** Word Error Rate (WER)  
**Model:** Transfer Learning-based ASR for Domain-Specific Sentences

| Speaker ID | Domain / Application         | WER (Test Data) | WER (Real-Time Test Data) |
|------------|------------------------------|------------------|-----------------------------|
| MRA (mild) | Handling Departmental Stores | 4%              | 6%                          |
| FGA (mod)  | Classroom Assistance         | 5%              | 8%                          |
| MMU (mod)  | Handling Departmental Stores | 7.5%            | 9%                          |
| MGN (mod)  | Handling a Nursery           | 8.3%            | 11%                         |
| MKA (mod)  | Classroom Assistance         | 10%             | 12%                         |
| FDH (mod)  | Handling a Xerox Shop        | 10.2%           | 12%                         |

---

##  TTS Performance Metrics

### HMM-based TTS (HTS)

- **Speakers:** 10 moderate, 7 mild dysarthric speakers
- **Findings:**
  - Higher intelligibility compared to Tacotron-based systems
  - Speaker identity **not** preserved
  - **MOS (Mean Opinion Score):**
    - Mild Speakers: **3.0**
    - Moderate Speakers: **2.8**

### Tacotron-based TTS

- **Speakers:** 7 mild dysarthric speakers
- **Findings:**
  - Speaker identity preserved
  - Lower intelligibility than HTS
  - **MOS:** **2.5**

---

## Summary

- ASR models demonstrate low WER for mild speakers (as low as 4%) and acceptable performance in real-time conditions.
- HTS-based TTS systems are more intelligible but compromise speaker identity.
- Tacotron-based TTS systems better preserve speaker identity but have lower intelligibility.


# Publications:

- T. A. Mariya Celin, P. Vijayalakshmi, T. Nagarajan, "Data augmentation techniques for transfer learning-based continuous dysarthric speech recognition", Circuits, Systems, and Signal Processing, Vol. 42, pp. 601 -  622, 2022.
- M. Dhanalakshmi, T. Nagarajan, P. Vijayalakshmi, "Significant sensors and parameters in assessment of dysarthric speech", Sensor Review, Vol. 41, pp. 271-286, 2021.
- T. A. Mariya Celin, T. Nagarajan, P. Vijayalakshmi, "Data Augmentation using virtual microphone array synthesis and multi-resolution feature extraction for isolated word dysarthric speech recognition", IEEE Journal of selected topics on signal processing, Vol. 14, No. 2, pp. 346 – 354, 2020.
- T. A. MariyaCelin, G. Anushiya Rachel, T. Nagarajan, P. Vijayalakshmi, "A Weighted Speaker-Specific Confusion Transducer Based Augmentative and Alternative Speech Communication Aid for Dysarthric Speakers", IEEE Transactions on Neural Systems and Rehabilitation Engineering, Vol. 27, Issue 2, pp. 187-197, 2019.
- M. Dhanalakshmi, T. A. Mariya Celin, T. Nagarajan, P. Vijayalakshmi, "Speech-input speech-output communication for dysarthric speakers using HMM-based speech recognition and adaptive synthesis system", Circuits, Systems, and Signal Processing, Vol. 37, pp. 674-703, 2018.
- M. Dhanalakshmi, T. A. Mariya Celin, T. Nagarajan, P. Vijayalakshmi, "Electromagnetic articulograph sensor-to-sound unit mapping-based intelligibility assessment of dysarthric speech", in Proc. of IEEE TENCON, pp. 1784-1789, 2017.
- T. A. Mariya Celin, T. Nagarajan, P. Vijayalakshmi, "Dysarthric speech corpus in tamil for rehabilitation research", in Proc. of IEEE TENCON, pp. 2610-2613, 2016.
- P. Vijayalakshmi, T. Nagarajan, "Assessment and intelligibility modification for dysarthric speakers", Chapter 3 – Voice Technologies for Reconstruction and Enhancement, De Gruyter Series in Speech Technology and Text Mining in Medicine and Healthcare, pp. 67 – 94, 2020.
- P. Vijayalakshmi, T. A. Mariya Celin, T. Nagarajan, "Selective pole modification-based technique for the analysis and detection of hypernasality", Chapter 2 – Signal and Acoustic Modeling for Speech and Communication Disorders, De Gruyter Series in Speech Technology and Text Mining in Medicine and Healthcare, pp. 33 – 68, 2018.
