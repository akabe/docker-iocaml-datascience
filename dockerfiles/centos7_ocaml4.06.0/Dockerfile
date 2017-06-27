FROM akabe/iocaml:centos7_ocaml4.06.0

ENV TENSORFLOW_VERSION 1.1.0
ENV LD_LIBRARY_PATH    /usr/lib:$LD_LIBRARY_PATH
ENV LIBRARY_PATH       /usr/lib:$LIBRARY_PATH

ADD MariaDB.repo /etc/yum.repos.d/MariaDB.repo

RUN curl -L "https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-linux-x86_64-${TENSORFLOW_VERSION}.tar.gz" | sudo tar xz -C /usr && \
    sudo yum -y install epel-release && \
    sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm && \
    sudo yum install -y --enablerepo=epel,nux-dextop \
      rsync \
      aspcud \
      bzip2 \
      gfortran \
      openssh-clients \
      blas-devel \
      lapack-devel \
      gsl-devel \
      libffi-devel \
      fftw-devel \
      libsvm-devel \
      cairo-devel \
      plplot-devel \
      eigen3-devel \
      MariaDB-devel \
      postgresql-devel \
      sqlite-devel \
      libcurl-devel \
      gmp-devel \
      openssl-devel \
      ImageMagick \
      ffmpeg && \
    sudo ln -sf /usr/lib64/libmysqlclient.so.18.0.0 /usr/lib/libmysqlclient.so && \
    \
    eval $(opam config env) && \
    \
    opam update && \
    opam upgrade -y && \
    (opam install -y batteries lwt_ssl tls 'cohttp>=0.22.0' || :) && \
    opam install -y \
      num \
      'core>=v0.9.0' \
      'async>=v0.9.0' \
      lacaml \
      slap \
      lbfgs \
      ocephes \
      oml \
      gsl \
      fftw3 \
      gpr \
      owl \
      'cairo2>=0.5' \
      plplot \
      archimedes \
      mysql \
      'mariadb>=0.8.1' \
      postgresql \
      sqlite3 \
      ocurl \
      'oasis>=0.4.0' && \
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
    : install tensorflow && \
    curl -L "https://github.com/LaurentMazare/tensorflow-ocaml/archive/0.0.10.1.tar.gz" \
         -o /tmp/tensorflow-ocaml-0.0.10.1.tar.gz && \
    tar zxf /tmp/tensorflow-ocaml-0.0.10.1.tar.gz -C /tmp && \
    ( \
      cd /tmp/tensorflow-ocaml-0.0.10.1 && \
      sed -i 's/(no_dynlink)//' src/wrapper/jbuild && \
      sed -i 's/(modes (native))//' src/wrapper/jbuild \
    ) && \
    opam pin add -y /tmp/tensorflow-ocaml-0.0.10.1 && \
    rm -rf /tmp/tensorflow-ocaml-0.0.10.1.tar.gz /tmp/tensorflow-ocaml-0.0.10.1 && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    opam uninstall oasis && \
    \
    sudo yum remove -y rsync aspcud bzip2 gfortran

ADD custom.css /home/opam/.jupyter/custom/custom.css
ADD notebook.json /home/opam/.jupyter/nbconfig/notebook.json

RUN sudo chown opam:opam -R /home/opam/.jupyter && \
    curl -L https://raw.githubusercontent.com/andrewray/iocaml/master/profile/static/custom/iocamlnblogo.png \
         -o /home/opam/.jupyter/custom/iocamlnblogo.png
