FROM akabe/iocaml:centos6_ocaml4.03.0
RUN sudo yum install -y gfortran blas-devel lapack-devel gsl-devel libffi-devel && \
    \
    opam install -y lacaml slap lbfgs ocephes oml gsl && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    sudo yum remove -y gfortran
