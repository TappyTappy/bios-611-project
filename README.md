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
docker build . -t yl611proj
```

Then you run:

```
docker run -v $(pwd):/home/rstudio/project -p 8787:8787 -e PASSWORD=<1234>
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

Information about Makefile
--------------------------

Makefile is a textual description of the relationships between artifacts. 
It documents instructions and objects needed to construct each artifact.
User can use tool make to reproduce every artifact by issueing the corresponding command.

Consider this snippet from the Makefile included in this project:

```
# Since our clustering is based on a variational auto-encoder it is
# difficult to understand what the clusters represent.  Here we use
# gradient boosting to train a tree model on the raw data to predict
# each cluster. From this model we can extract the important variables
# for each cluster and report their medians. We simply save the labels
# here for future use.
derived_data/cluster_labels.csv: .created-dirs explain_encoding.R derived_data/demographic_ae_sdf.csv
	Rscript explain_encoding.R
```

The lines with `#` are comments which just describe the target. Here
we describe an artifact (`derived_data/cluster_labels.csv`), its
dependencies (`.created-dirs`, `explain_encoding.R`,
`derived_data/demographic_ae_sdf.csv`) and how to build it `Rscript
explain_encoding.R`. If we invoke Make like so:

```
make derived_data/???.csv
```

Make will construct this artifact for us. If the dependency
`derived_data/demographic_ae_sdf.csv` doesn't exist for some reason it
will _also_ construct that artifact on the way. This greatly
simplifies the reproducibility of builds and also documents
dependencies.

Analysis Goal
===============


Results
=======

In progress... 
But for results so far, you can access it with:

```
make writeup.pdf
```
This command will build my project report.

