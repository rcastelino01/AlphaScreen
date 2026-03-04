# AlphaScreen
This is a guide on how to run an AlphaFold3 screen between your target protein bait(s) and a library of proteins of your choice. These scripts are specifically designed for use on Yale's high performance computing clusters. This guide assumes knowledge in basic Linux. For any questions, please email rithik.castelino@yale.edu.
For Tang lab members, please remember to fill out the run tracker in the shared OneDrive.

### Requirements
* Request AlphaFold3 weights from Google DeepMind (https://docs.google.com/forms/d/e/1FAIpQLSfWZAgo1aYk0O4MuAXZj8xRQ8DafeFJnldNOnh_13qAx2ceZw/viewform)
* Request a Bouchet cluster account from Yale's Center for Research Computing (https://docs.google.com/forms/d/e/1FAIpQLSfLghL1gSHRkIQj73zPzvLCJ0sojm9aUHZLQGBD_auD054gqA/viewform)
* Compile a .fasta file of all of the proteins that you would like to screen your bait against.

### Prepare Directory
Due to space considerations, only run AlphaScreen in the **Project** directory. After entering the **Project** directory, clone this git repository.
```
git clone https://github.com/rcastelino01/AlphaScreen
```
Place your .fasta file and your AlphaFold3 weights (your af3.bin.zst) file in the **inputs** and **weights** folders respectively..

### Running AlphaScreen
To run AlphaScreen first request an interactive session and then run `af_setup.sh`.
```
salloc
source af_setup.sh
```
Follow the interactive prompts, specifying the number of baits, and then pasting the sequences of your baits (IN ALL CAPS) as specified. After entering your last bait sequence, there will be a delay as the scripts work their magic.
After they are done, start the screen with the following command.
```
source af_run.sh
```
You can monitor your predictions with the following command.
```
squeue -u "Your user id"
```

### Analyze
To analyze your results and compile the average iPTM scores across the top 5 predictions for each bait(s)-target group, request an interactive session and run the `af_analyze.sh` script.
```
salloc
source af_analyze.sh
```
Your scores are now stored in file called Outputs/avg_ipTMs.csv.
