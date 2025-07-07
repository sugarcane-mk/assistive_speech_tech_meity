Assistive Speech Technologies
-
This repository contains ASR and TTS models trained at Speech Lab, Department of ECE, SSN College of Engineering, Chennai, as a part of the Assistive Technologies module of the Bashini: NLTM Speech Technologies in Indian Languages Project, funded by the Ministry of Electronics and Information Technology, Govt. of India.

The data used to train these models are available at https://github.com/SpeechLabSSN/dysarthric_data.git

To gain access to the data, please send an email to speechlabssn@gmail.com with details of how you wish to use the data.

ASR
 
The prerequisites for running the decoding script and test wav files are shared in the zip folders (assistive_speech_tech_meity.zip and ASR_test.zip)

![image](https://github.com/user-attachments/assets/c4ffe85d-772b-44e1-a578-7562f73be6db)

 
The ones to be present in the /usr/lib directory are given as a separate zip file, by the name “prerequisites.zip”, which is present in the assistive_speech_tech_meity.zip
The steps ,utils directories (old versions), kaldi/src and kaldi/tools (old versions) used for model building and testing are given in the same zip file. The path.sh is also provided.
testing_dysarthric_asr.sh (this is for single utterance decoding),is updated and given in the assistive_speech_tech_meity.zip. 
testing_dysarthric_asr_all.sh is for multiple sentences decoding. The speaker ID needs to be entered in the SPK variable which is defined in the first line of the code. The decoding generated in decode.1.log is made available in ./output_MONO.txt. The WER is present in the decode/scoring_kaldi/best_wer.
ASR_test_data.zip is also provided. It is to be placed as egs/assistive_speech_tech_meity/ASR_test_data.
 
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



Publications:
-
- T. A. Mariya Celin, P. Vijayalakshmi, T. Nagarajan, "Data augmentation techniques for transfer learning-based continuous dysarthric speech recognition", Circuits, Systems, and Signal Processing, Vol. 42, pp. 601 -  622, 2022.
- M. Dhanalakshmi, T. Nagarajan, P. Vijayalakshmi, "Significant sensors and parameters in assessment of dysarthric speech", Sensor Review, Vol. 41, pp. 271-286, 2021.
- T. A. Mariya Celin, T. Nagarajan, P. Vijayalakshmi, "Data Augmentation using virtual microphone array synthesis and multi-resolution feature extraction for isolated word dysarthric speech recognition", IEEE Journal of selected topics on signal processing, Vol. 14, No. 2, pp. 346 – 354, 2020.
- T. A. MariyaCelin, G. Anushiya Rachel, T. Nagarajan, P. Vijayalakshmi, "A Weighted Speaker-Specific Confusion Transducer Based Augmentative and Alternative Speech Communication Aid for Dysarthric Speakers", IEEE Transactions on Neural Systems and Rehabilitation Engineering, Vol. 27, Issue 2, pp. 187-197, 2019.
- M. Dhanalakshmi, T. A. Mariya Celin, T. Nagarajan, P. Vijayalakshmi, "Speech-input speech-output communication for dysarthric speakers using HMM-based speech recognition and adaptive synthesis system", Circuits, Systems, and Signal Processing, Vol. 37, pp. 674-703, 2018.
- M. Dhanalakshmi, T. A. Mariya Celin, T. Nagarajan, P. Vijayalakshmi, "Electromagnetic articulograph sensor-to-sound unit mapping-based intelligibility assessment of dysarthric speech", in Proc. of IEEE TENCON, pp. 1784-1789, 2017.
- T. A. Mariya Celin, T. Nagarajan, P. Vijayalakshmi, "Dysarthric speech corpus in tamil for rehabilitation research", in Proc. of IEEE TENCON, pp. 2610-2613, 2016.
- P. Vijayalakshmi, T. Nagarajan, "Assessment and intelligibility modification for dysarthric speakers", Chapter 3 – Voice Technologies for Reconstruction and Enhancement, De Gruyter Series in Speech Technology and Text Mining in Medicine and Healthcare, pp. 67 – 94, 2020.
- P. Vijayalakshmi, T. A. Mariya Celin, T. Nagarajan, "Selective pole modification-based technique for the analysis and detection of hypernasality", Chapter 2 – Signal and Acoustic Modeling for Speech and Communication Disorders, De Gruyter Series in Speech Technology and Text Mining in Medicine and Healthcare, pp. 33 – 68, 2018.
