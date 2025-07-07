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
