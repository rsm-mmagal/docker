#!/bin/bash
set -e

UBUNTU_VERSION=${UBUNTU_VERSION:-`lsb_release -sc`}
CRAN=${CRAN:-https://cran.r-project.org}

##  mechanism to force source installs if we're using RSPM
CRAN_SOURCE=${CRAN/"__linux__/$UBUNTU_VERSION/"/""}

## source install if using RSPM and arm64 image
if [ "$(uname -m)" = "aarch64" ]; then
  CRAN=https://cran.r-project.org
  CRAN_SOURCE=${CRAN/"__linux__/$UBUNTU_VERSION/"/""}
  CRAN=$CRAN_SOURCE
fi

NCPUS=${NCPUS:--1}

if [ -f "/opt/conda/bin/R" ]; then
  mamba install --quiet --yes -c conda-forge snappy cmake
else
  export DEBIAN_FRONTEND=noninteractive
  apt-get update -qq && apt-get -y --no-install-recommends install \
      libicu-dev \
      zlib1g-dev \
      libglpk-dev \
      libgmp3-dev \
      libxml2-dev \
      cmake \
      git \
      libharfbuzz-dev \
      libfribidi-dev \
      libfreetype6-dev \
      libpng-dev \
      libtiff5-dev \
      libjpeg-dev \
      libcurl4-openssl-dev \
      && rm -rf /var/lib/apt/lists/*
fi

# removed reticulate due to issue compiling RcppTOML
R -e "install.packages('igraph', repo='${CRAN}', Ncpus=${NCPUS})" \
  -e "install.packages(c('radiant', 'png', 'bslib', 'gitgadget', 'miniUI', 'webshot', 'tinytex', 'svglite'), repo='${CRAN}', Ncpus=${NCPUS})" \
  -e "install.packages(c('remotes', 'formatR', 'styler', 'renv'), repo='${CRAN}', Ncpus=${NCPUS})" \
  -e "install.packages(c('fs', 'janitor', 'dm', 'palmerpenguins', 'stringr', 'tictoc'), repo='${CRAN}', Ncpus=${NCPUS})" \
  -e "install.packages(c('httpgd', 'languageserver'), repo='${CRAN}', Ncpus=${NCPUS})" \
  -e "remotes::install_github('radiant-rstats/radiant.update', upgrade = 'never')" \
  -e "remotes::install_github('vnijs/gitgadget', upgrade = 'never')" \
  -e "remotes::install_github('IRkernel/IRkernel', upgrade = 'never')"  \
  -e "remotes::install_github('IRkernel/IRdisplay', upgrade = 'never')" \
  -e "IRkernel::installspec(user=FALSE)" \
  -e "remotes::install_github('radiant-rstats/radiant.data', upgrade = 'never')" \
  -e "remotes::install_github('radiant-rstats/radiant.design', upgrade = 'never')" \
  -e "remotes::install_github('radiant-rstats/radiant.basics', upgrade = 'never')" \
  -e "remotes::install_github('radiant-rstats/radiant.model', upgrade = 'never')" \
  -e "remotes::install_github('radiant-rstats/radiant.multivariate', upgrade = 'never')" \
  -e "remotes::install_github('radiant-rstats/radiant', upgrade = 'never')" \
  -e "remotes::install_github('radiant-rstats/radiant.update', upgrade = 'never')" \
  -e "install.packages('duckdb', repo='${CRAN}', Ncpus=${NCPUS})"

rm -rf /tmp/downloaded_packages
