#!/bin/bash

echo "Generating dockerfiles/$TAG/Dockerfile (ALIAS=${ALIAS[@]})..."

rm -rf dockerfiles/$TAG
mkdir -p dockerfiles/$TAG

cat <<EOF >dockerfiles/$TAG/Dockerfile
FROM akabe/iocaml:${TAG}
EOF

cat <<'EOF' >>dockerfiles/$TAG/Dockerfile

RUN sudo yum install -y gfortran blas-devel lapack-devel gsl-devel libffi-devel cairo-devel postgresql-devel && \
    (opam install -y batteries || :) && \
    opam install -y core lacaml slap lbfgs ocephes oml gsl cairo2 archimedes postgresql && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    sudo yum remove -y gfortran
EOF
