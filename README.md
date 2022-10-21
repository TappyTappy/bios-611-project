BIOS 611 Project: Stephen Curry stats 2009-2021 in NBA
======================================================
#### Author: Yuchen/Tappy Li 
###### Data Source: Kaggle by MUJIN JO

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
docker build . -t yl
```

Then you run:

```
docker run -v $(pwd):/home/rstudio/project -p 8787:8787 --rm -it yl
```

This code starts up the user rstudio in Docker environment.

You then visit http://localhost:8787 via a browser on your device to
access Docker rstudio environment. (Note: `-p 8888:8888\` is the command used to start a python environment. 
This type of files will be added in the future.)

To reproduce thhe final report, visit the terminal in rstudio and run:

```
make report.pdf
```

Project Organization
====================

Please see the Makefile for project structure.


Analysis Goal
===============
This project focuses on:
1. Stephen Curry's changes in skills over time.
2. Stephen Curry's influence on whole team.
3. Predict Golden State Warriors' future game result based on Stephen Curry's statistics.

Results
=======

In progress... 
But for results so far, you can access it with:

```
make report.pdf
```
This command will build my project report.

