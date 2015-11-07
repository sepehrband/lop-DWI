#! /bin/sh

# Denoising on human brian data
mycodesdir='/Users/Farshid/Farshid/MRI_data/Spiral14_Human/DTI_REPEAT'
InputDir='/Users/Farshid/Farshid/MRI_data/Spiral14_Human/DTI_REPEAT/Reged'
myoutput='/Users/Farshid/Farshid/MRI_data/Spiral14_Human/DTI_REPEAT/Reged'


cutoff=18

# Read and Denoise 
cd $InputDir
myrunfiles="Koay_*.nii"
for f in $myrunfiles
do
	fileName=$f
	DenName="lop_${f}"
	echo "Denoising file ${fileName} and saving it as ${DenName}" >> $mycodesdir/log.txt
	date >> $mycodesdir/log.txt
	sh /Users/Farshid/Dropbox/PhD/Mine/Spiral14/Human/myDenMat.sh $fileName $cutoff $myoutput $DenName $InputDir
	# echo $fileName $cutoff $myoutput $DenName $InputDir
done
