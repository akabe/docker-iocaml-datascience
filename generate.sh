#!/bin/bash

function common_scripts() {
    cat <<'EOF'
    opam install -y lacaml slap lbfgs ocephes oml gsl \
                    cairo2 archimedes && \
    \
    find $HOME/.opam -regex '.*\\.\\(cmt\\|cmti\\|annot\\|byte\\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/build
EOF
}

function alpine_scripts() {
    cat <<EOF
FROM akabe/iocaml:${TAG}

RUN sudo apk add --no-cache --upgrade \\
             libffi lapack gsl \
             cairo && \\
    sudo apk add --no-cache --virtual .build-dependencies \\
             m4 gfortran lapack-dev gsl-dev \\
             libffi-dev cairo-dev && \\
    \\
$(common_scripts) && \\
    \\
    sudo apk del .build-dependencies
EOF
}

case $OS in
    alpine )
	alpine_scripts
    ;;
esac
