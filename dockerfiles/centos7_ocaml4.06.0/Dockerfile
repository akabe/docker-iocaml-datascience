FROM akabe/iocaml:centos7_ocaml4.06.0

ENV TENSORFLOW_VERSION 1.1.0
ENV LD_LIBRARY_PATH    /usr/lib:$LD_LIBRARY_PATH
ENV LIBRARY_PATH       /usr/lib:$LIBRARY_PATH

RUN sudo yum install -y rsync gfortran \
                     blas-devel lapack-devel gsl-devel libffi-devel cairo-devel postgresql-devel && \
    \
    (opam install -y batteries || :) && \
    opam install -y core lacaml slap lbfgs ocephes oml gsl cairo2 archimedes postgresql && \
    \
    curl -L "https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-linux-x86_64-${TENSORFLOW_VERSION}.tar.gz" | sudo tar xz -C /usr && \
    curl -L "https://github.com/LaurentMazare/tensorflow-ocaml/archive/0.0.10.1.tar.gz" \
         -o /tmp/tensorflow-ocaml-0.0.10.1.tar.gz && \
    tar zxf /tmp/tensorflow-ocaml-0.0.10.1.tar.gz -C /tmp && \
    ( \
      cd /tmp/tensorflow-ocaml-0.0.10.1 && \
      sed -i 's/(no_dynlink)//' src/wrapper/jbuild && \
      sed -i 's/(modes (native))//' src/wrapper/jbuild \
    ) && \
    opam pin add -y /tmp/tensorflow-ocaml-0.0.10.1 && \
    rm -rf /tmp/tensorflow-ocaml-0.0.10.1.tar.gz \
           /tmp/tensorflow-ocaml-0.0.10.1 && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    sudo yum remove -y rsync gfortran
