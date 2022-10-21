FROM rocker/verse
# ARG linux_user_pwd
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN adduser rstudio sudo
# RUN apt update && apt install -y software-properties-common
RUN echo "rstudio:1234" | chpasswd
RUN Rscript --no-restore --no-save -e "install.packages('ggplot2')"
RUN Rscript --no-restore --no-save -e "install.packages('gbm')"
RUN Rscript --no-restore --no-save -e "tinytex::tlmgr_install(c(\"wrapfig\",\"ec\",\"ulem\",\"amsmath\",\"capt-of\"))"
RUN Rscript --no-restore --no-save -e "tinytex::tlmgr_install(c(\"hyperref\",\"iftex\",\"pdftexcmds\",\"infwarerr\"))"
RUN Rscript --no-restore --no-save -e "tinytex::tlmgr_install(c(\"kvoptions\",\"epstopdf\",\"epstopdf-pkg\"))"
RUN Rscript --no-restore --no-save -e "tinytex::tlmgr_install(c(\"hanging\",\"grfext\"))"
RUN Rscript --no-restore --no-save -e "tinytex::tlmgr_install(c(\"etoolbox\",\"xcolor\",\"geometry\"))"
