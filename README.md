BIOS 611 Project:  The 2017 Astro’s sign-stealing scandal 
======================================================
#### Author: Yuchen/Tappy Li 
#### Contributors: Fab Joseph, Grant Mcgrew, and Ariel Wang

Data Source
===========
Data is Plural (http://signstealingscandal.com/files/) platform, collected by an Astros fan named Tony Adams who rewatched home games from the 2017 season and charted pitches and bangs (the way the Astros cheated was by banging on trash cans to indicate what pitch was coming). 
For easy viewing: https://docs.google.com/spreadsheets/d/1Zm2ndPtTIl3n569JViVz8ki2hJW2lpYHvRjQZV_32dk/edit?usp=sharing. 

Project Instructions
====================

This repository is best used via Docker. 
Please see Dockerfile for more information related to specific commands.

Information about Docker
------------------------

Docker builds an environment which
contains all the softwares and tools needed for the project. 
User can use Docker to run the project without having to install tedious softwares and libraries.

To start
------------------

To build the docker image, you run

```
docker build . -t 611
```

Then you run:

```
docker run -v $(pwd):/home/rstudio/work -p 8787:8787 -e PASSWORD=work -it 611
```

This code starts up the user rstudio in Docker environment. Please set working directory to current work directory in rstudio. 

You then visit http://localhost:8787 via a browser on your device to
access Docker rstudio. (Note: `-p 8888:8888\` is the command used to start a python environment. 
This type of files will be added in the future.)

To reproduce thhe final report, visit the terminal in rstudio and run:

```
make report.pdf
```

Project Organization
====================

Please see the Makefile for project structure.


Analysis Goal:  Create a model that predicts the effect of sign stealing (win or loss).
===============
This project focuses on:
1. The usual outcome of a batting event when a bang was heard (single, double, home run, or grand slam).
2. If the number of bangs were different for each opponent or were they more heavily used against better opposition.
3. If we were to plot a player’s On-base Plus Slugging (OPS), which measures how well a hitter can reach base and hit for power, before they engaged in sign-stealing, so 2016, compared to their (OPS) in 2017, when they did engage in sign-stealing, how would these numbers differ.
4. How the slugging percentage (SLG), which measures the number of bases a player records at-bat, for batters batting with a bang and batters batting without a bang, differed in 2017.

Results
=======
Brief findings: the Astros generally did not appear to use their cheating mechanism more in important situations, and when they did use it, the outcomes were not very different from the usual.

You can access project report via:

```
make report.pdf
```
This command will build my project report.





