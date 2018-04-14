FROM jupyter/r-notebook:599db13f9123

MAINTAINER Michael Weylandt <michael.weylandt@rice.edu>

USER root

# Customized using Jupyter Notebook R Stack https://github.com/jupyter/docker-stacks/tree/master/r-notebook

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    gfortran \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER

# R packages

RUN conda config --add channels r
RUN conda config --add channels bioconda

RUN conda install --quiet --yes \
    'r-base=3.3.2' \
    'r-irkernel' \
    'r-plyr' \
    'r-devtools' \
    'r-shiny' \
    'r-reshape2' \
    'r-nycflights13' \
    'r-tidyverse' \
    'r-ggplot2' \
    'r-xts' \
    'r-readr' \
    'r-TTR' \
    'r-tidyverse' \
    'r-lubridate' \
    'r-quantmod' && conda clean -tipsy
    
## These are not available via conda
RUN echo "chooseCRANmirror(ind=1); install.packages(c('forecast','PerformanceAnalytics', 'PortfolioAnalytics', 'mapdata', 'ggthemes', 'ROI'))" | R --vanilla

WORKDIR /home/user
ADD . /home/user

