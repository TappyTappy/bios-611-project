FROM rocker/verse


RUN Rscript --no-restore --no-save -e "install.packages('ggplot2')"
RUN Rscript --no-restore --no-save -e "install.packages('stringi')"
RUN Rscript --no-restore --no-save -e "install.packages('viridis')"
RUN Rscript --no-restore --no-save -e "install.packages('rsample')"
RUN Rscript --no-restore --no-save -e "install.packages('glmnet')"

