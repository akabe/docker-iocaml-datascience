FROM akabe/iocaml:alpine3.5_ocaml4.04.1
RUN sudo apk add --no-cache --upgrade libffi lapack gsl && \
    sudo apk add --no-cache --virtual=.build-dependencies \
             gfortran lapack-dev gsl-dev libffi-dev && \
    \
    opam install -y lacaml slap lbfgs ocephes oml gsl && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    sudo apk del .build-dependencies
