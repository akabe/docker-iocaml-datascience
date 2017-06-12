FROM akabe/iocaml:debian8_ocaml4.05.0

RUN sudo apt-get install -y gfortran libffi-dev libblas-dev liblapack-dev libgsl0-dev libcairo2-dev libpq-dev && \
    \
    (opam install -y batteries || :) && \
    opam install -y core lacaml slap lbfgs ocephes oml gsl cairo2 archimedes postgresql && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    sudo apt-get purge -y gfortran
