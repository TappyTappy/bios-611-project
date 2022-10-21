FROM rocker/verse
ARG linux_user_pwd
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN adduser rstudio sudo
RUN apt update && apt install -y software-properties-common
RUN Rscript --no-restore --no-save -e "install.packages('reticulate')"
RUN echo "rstudio:$linux_user_pwd" | chpasswd
RUN Rscript --no-restore --no-save -e "install.packages('ggplot')"
RUN Rscript --no-restore --no-save -e "install.packages('gbm')"
RUN Rscript --no-restore --no-save -e "install.packages('svglite')"
RUN Rscript --no-restore --no-save -e "install.packages(c(\"plumber\"))"
RUN Rscript --no-restore --no-save -e "install.packages(c(\"verification\"))"
