FROM akabe/iocaml:debian8_ocaml4.04.1
RUN sudo apt-get install -y gfortran libffi-dev libblas-dev liblapack-dev libgsl0-dev libcairo2-dev && \
    \
    opam install -y core batteries \
                    lacaml slap lbfgs ocephes oml gsl cairo2 archimedes && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    sudo apt-get purge -y gfortran
