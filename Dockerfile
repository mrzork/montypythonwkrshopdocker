FROM rocker/tidyverse
MAINTAINER Camilo Herrera <ch@camiloherrera.co>
# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libssl1.0.0

# system library dependency for the euler app
RUN apt-get update && apt-get install -y \
    libmpfr-dev

# basic shiny functionality
RUN R -e "install.packages(c('shiny', 'rmarkdown','tidyverse','lubridate','shinydashboard','ggplot2','ggvis','googleVis','rpivotTable','DT','xts','dygraphs','rpivotTable'), repos='https://cloud.r-project.org/')"
RUN apt-get install libudunits2-0 libudunits2-dev whois
ADD https://gist.githubusercontent.com/mrzork/dff40b85342c3f461ac9a9ed0da70ceb/raw/cae81c347bc209125d0d761e462d0381b47cb8d3/mkusers.sh /
ADD https://gist.githubusercontent.com/mrzork/24c51d45e940b757bc71873f45129e84/raw/13b04aa5d49861104b6c9dbd8ef958004124b48d/users.csv /
RUN chmod 777 /mkusers.sh
RUN /mkusers.sh
