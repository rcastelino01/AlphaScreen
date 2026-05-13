# AlphaScreen
This is a guide on how to run an AlphaFold3 screen between your target protein bait(s) and a library of proteins of your choice. There are many excellent software packages for this same function, but this custom script was written for our own ease of extensibility. These scripts are specifically designed for use on Yale's high performance computing clusters (HPC) but it it also applicable for use on any other SLURM-based HPC. This guide assumes knowledge in basic Linux. For any questions, please email rithik.castelino@yale.edu.

### Requirements
* Request AlphaFold3 weights from Google DeepMind (https://docs.google.com/forms/d/e/1FAIpQLSfWZAgo1aYk0O4MuAXZj8xRQ8DafeFJnldNOnh_13qAx2ceZw/viewform)
* Request an account at your institution's HPC.
* Compile a .fasta file of all of the proteins that you would like to screen your bait against. If you library is greater than 9,999 you will have to break it up into separate chunks.

### Prepare Directory
Due to space considerations, only run AlphaScreen in the **Project** directory. After entering the **Project** directory, clone this git repository.
```
git clone https://github.com/rcastelino01/AlphaScreen
```
Place your .fasta file and your AlphaFold3 weights (your af3.bin.zst) file in the **inputs** and **weights** folders respectively.

Update the account name and appropriate cpu & gpu partition names in **utilities/af_cpu.sh** and **utilities/af\_gpu.sh** See your institution's HPC documentation for these details.

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
Your scores are now stored in file called **Outputs/avg\_statistics.csv**.
