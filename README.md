# Mechanomyography Based Finger Gesture Recognizer

[Mechanomyography](https://en.wikipedia.org/wiki/Mechanomyogram) (MMG) is the principle of sound-generated by our muscle fibers, 
when they're activated for initiating a motion. These sounds are very low frequency and are detectable at the skin-surface. 
They are usually captured using a wearable microphone or accelerometers. 

## System Description
The system works by first detecting MMG signal by a moving window energy detector and thresholding. Once the MMG window is identified, 
a set of 14 statistical features (see below for a list) are computed from the window. PCA is used for orthogonalizing the features while 
reducing the feature count by keeping features that represent 95\% of the variance in the data. These reduced feature sets are passed 
through machine learning algorithms to train the system at train-time. At test-time, a class of gesture is predicted in real-time as seen 
in the video below:

<a href="http://www.youtube.com/watch?feature=player_embedded&v=YouJtJQiOmU
" target="_blank"><img src="http://img.youtube.com/vi/YouJtJQiOmU/0.jpg" 
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>


### Feature Extraction
The code for statistical feature extraction from Mechanomyography time-series data is avaiable in 
[generateFeatures.m](https://github.com/debapratimsaha/mmg-PatternRecognition/blob/master/matlab/pca_lda/generateFeatures.m)

A few selected features are:
* Integrated Absolute MMG amplitude
* Mean of Absolute Amplitude
* Mean of Absolute-deviation
* Skewness and Kurtosis 
* Number of Zero-crossings
* Slope of Sign Change
* Wilson's Amplitude
* Coefficients of 7th AutoRegressive (AR) Coefficients

TODO: Ceptrum Coefficients from AR Coefficients : They're known to contain highly discriminative information for the MMG signal.


