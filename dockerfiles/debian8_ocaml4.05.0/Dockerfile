FROM akabe/iocaml:debian8_ocaml4.05.0

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
      libsvm-dev \
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
      ocurl \
      'oasis>=0.4.0' && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    eval $(opam config env) && \
    \
    : install libsvm && \
    curl -L https://bitbucket.org/ogu/libsvm-ocaml/downloads/libsvm-ocaml-0.9.3.tar.gz \
         -o /tmp/libsvm-ocaml-0.9.3.tar.gz && \
    tar zxf /tmp/libsvm-ocaml-0.9.3.tar.gz -C /tmp && \
    ( \
      cd /tmp/libsvm-ocaml-0.9.3 && \
      oasis setup && \
      ./configure --prefix=$(opam config var prefix) && \
      make && \
      make install \
    ) && \
    rm -rf /tmp/libsvm-ocaml-0.9.3.tar.gz /tmp/libsvm-ocaml-0.9.3 && \
    \
    opam uninstall oasis && \
    \
    sudo apt-get purge -y gfortran

ADD custom.css /home/opam/.jupyter/custom/custom.css
ADD notebook.json /home/opam/.jupyter/nbconfig/notebook.json
