FROM akabe/iocaml:alpine3.5_ocaml4.06.0
RUN sudo apk add --no-cache --upgrade libffi-dev lapack-dev gsl-dev cairo-dev postgresql-dev && \
    sudo apk add --no-cache --virtual=.build-dependencies bash gfortran && \
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
    sudo apk del .build-dependencies
