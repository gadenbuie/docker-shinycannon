FROM rocker/r-ver:3.5.3

LABEL maintainer="Garrick Aden-Buie (Garrick.Aden-Buie@moffitt.org)"

RUN apt-get update && apt-get install -y wget default-jre-headless

# R packge deps
RUN apt-get update && apt-get install -y libcurl4-openssl-dev libssl1.0 libssl1.0-dev

RUN Rscript -e 'install.packages(c("pak","docopt")); pak::pkg_install("rstudio/shinyloadtest")'

ENV TMPDIR /tmp/cannon
RUN mkdir -p $TMPDIR && \
  cd $TMPDIR && \
  wget -O shinycannon.deb \
    https://s3.amazonaws.com/rstudio-shinycannon-build/2018-11-01-22:04:59_1.0.0-b267bad/deb/shinycannon_1.0.0-b267bad_amd64.deb && \
  dpkg -i shinycannon.deb && \
  rm -rf $TMPDIR

CMD ["bash"]
