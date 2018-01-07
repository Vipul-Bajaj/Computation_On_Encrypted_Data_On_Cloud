Here there are 3 scripts present each representing an encryption scheme

MMC.m - It uses the scheme :- DataMatrix1 + key4 & DataMatrix2 + key5

MMC_2.m - It uses the scheme :- key1*(DataMatrix1 + key4)*key2 & inverse(key2)*(DataMatrix + key5)*key3

MMC_3.m - It uses the scheme :- key1*(DataMatrix1)*key2 & inverse(key2)*DataMatrix*key3

To run any of the above scheme just execute the below command in command line in windows or terminal in linux having octave preinstalled.

octave {Name of the Script} {Dimension of the Matrix}

Eg:-  octave MMC.m 500

The above command will run the MMC.m script in octave for matrix having dimension 500*500.
