# SOOT PLAYGROUND

|  <img src="image.png" alt="logo" width="120"> | **SOOT PLAYGROUND**  
|:----------------------:|:--------------------|

This repository helps you to write various small analysis to know more about Java Programs.
* Clone the repository: 
    `Command: git clone git@github.com:CompL-Research/Soot-playground.git`

After cloning this repository, you might need few more steps before running the actual analysis.


## Directory Structure:

```
project-root/
├── scripts/
├── soot/
├── src/
├── Benchmarks/ (Should be added)
├── jdk-binaries/ (Should be added)
└── README.md
```
## Setup Guidelines

**Steps for Setting up the Repository.**

`Step 1:` Download the standard benchmarks for soot. (`Benchmarks` folder)
    
    Command: git clone git@github.com:adityaanand7/Benchmarks.git
This repo currently provides four benchmark-suites: 
1. DaCapo-9.12-MR1 Benchmark-Suite
2. SpecJVM 2008 Benchmark-Suite
3. SpecJBB 2005 Benchmark-Suite
4. Renaissance Benchmark-Suite
5. DaCapo-23.11-MR1-chopin Suite (Will be updated soon)

`Step 2:` Download a suitable jdk (any jdk8 suggested). (`jdk-binaries` folder)
    
    Command: git clone git@github.com:adityaanand7/jdk-binaries.git
             cd jdk-binaries
             unzip jdk1.8.0_301.zip
`Step 3:` Once you are done with both the steps, you are good do go. The `src` directory contains all the required code. You can add your new analysis in `analysis` folder and can invoke them from the `main/Main.java.`

`Step 4:`
For runnning you programs. You can go to the scripts folder and run:

    Command: cd scripts 
             bash benchmark.sh olddacapo avrora
The first arugument specifies the `benchmark suite` and the second specifies the `benchmark name`.<br>
**Benchmark Suites possible options:**
``` 
    * olddacapo for (dacapo-9.12-MR1-bach) <br>
    * newdacapo for (dacapo-23.11-MR1-chopin not implemented yet)<br>
    * jbb for (SpecJVM 2008)<br>
    * jvm for (SpecJBB 2005)<br>
    * ren for (Renaissance)<br>
```
**(Note if you have downloaded any other vm you need to updated the path in the script).** 
