FROM akabe/iocaml:ubuntu16.04_ocaml4.04.1
RUN sudo apt-get install -y gfortran libffi-dev libblas-dev liblapack-dev libgsl-dev && \
    \
    opam install -y lacaml slap lbfgs ocephes oml gsl && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    sudo apt-get purge -y gfortran
