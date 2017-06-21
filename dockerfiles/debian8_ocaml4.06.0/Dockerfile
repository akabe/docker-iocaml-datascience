FROM akabe/iocaml:debian8_ocaml4.06.0

ADD iocaml-datascience-extra.list /etc/apt/sources.list.d/iocaml-datascience-extra.list

RUN sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && \
    sudo apt-get update && \
    sudo apt-get install -y \
      gfortran \
      libffi-dev \
      libblas-dev \
      liblapack-dev \
      libgsl0-dev \
      libfftw3-dev \
      libcairo2-dev \
      libmariadb-dev \
      libpq-dev \
      libsqlite3-dev \
      libcurl4-openssl-dev \
      imagemagick \
      ffmpeg && \
    sudo ln -sf /usr/lib/x86_64-linux-gnu/libmysqlclient.so.20 /usr/lib/libmysqlclient.so && \
    \
    opam update && \
    (opam install -y batteries || :) && \
    opam install -y \
      num \
      'core>=v0.9.0' \
      lacaml \
      slap \
      lbfgs \
      ocephes \
      oml \
      gsl \
      fftw3 \
      'cairo2>=0.5' \
      archimedes \
      mysql \
      'mariadb>=0.8.1' \
      postgresql \
      sqlite3 \
      ocurl && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    sudo apt-get purge -y gfortran

ADD custom.css /home/opam/.jupyter/custom/custom.css
ADD notebook.json /home/opam/.jupyter/nbconfig/notebook.json
