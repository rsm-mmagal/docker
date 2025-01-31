#!/bin/bash

## Adapted from https://github.com/rocker-org/rocker-versioned2/blob/master/scripts/install_quarto.sh

set -e

## build ARGs
NCPUS=${NCPUS:--1}

##  mechanism to force source installs if we're using RSPM
UBUNTU_VERSION=${UBUNTU_VERSION:-`lsb_release -sc`}
CRAN=${CRAN:-https://cran.r-project.org}
CRAN_SOURCE=${CRAN/"__linux__/$UBUNTU_VERSION/"/""}

if [ "$(uname -m)" != "aarch64" ]; then
    ln -fs /usr/lib/rstudio-server/bin/quarto/bin/quarto /usr/local/bin
else
    # not available for aarch64 yet
    sudo apt-get update -qq && apt-get -y install gdebi-core
    wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.3.191/quarto-1.3.191-linux-arm64.deb -O quarto.deb
    sudo gdebi -n quarto.deb # adding -n to run non-interactively
    CRAN=$CRAN_SOURCE
fi

# Get R packages
R -e "install.packages('quarto', repo='${CRAN}', Ncpus=${NCPUS})"

# Clean up
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/downloaded_packages