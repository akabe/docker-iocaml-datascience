
#!/bin/bash

function common_scripts() {
    cat <<'EOF'
    (opam install -y batteries || :) && \
    opam install -y core lacaml slap lbfgs ocephes oml gsl cairo2 archimedes postgresql && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build
EOF
}

function alpine_scripts() {
    cat <<EOF
RUN sudo apk add --no-cache --upgrade libffi-dev lapack-dev gsl-dev cairo-dev postgresql-dev && \\
    sudo apk add --no-cache --virtual=.build-dependencies bash gfortran && \\
    \\
$(common_scripts) && \\
    \\
    sudo apk del .build-dependencies
EOF
}

function centos_scripts() {
    cat <<EOF
RUN sudo yum install -y gfortran blas-devel lapack-devel gsl-devel libffi-devel cairo-devel postgresql-devel && \\
    \\
$(common_scripts) && \\
    \\
    sudo yum remove -y gfortran
EOF
}

function debian_scripts() {
    cat <<EOF
RUN sudo apt-get install -y gfortran libffi-dev libblas-dev liblapack-dev libgsl0-dev libcairo2-dev libpq-dev && \\
    \\
$(common_scripts) && \\
    \\
    sudo apt-get purge -y gfortran
EOF
}

function ubuntu_scripts() {
    cat <<EOF
RUN sudo apt-get install -y gfortran libffi-dev libblas-dev liblapack-dev libgsl-dev libcairo2-dev libpq-dev && \\
    \\
$(common_scripts) && \\
    \\
    sudo apt-get purge -y gfortran
EOF
}

echo "Generating dockerfiles/$TAG/Dockerfile (ALIAS=${ALIAS[@]})..."

rm -rf dockerfiles/$TAG
mkdir -p dockerfiles/$TAG

cat <<EOF >dockerfiles/$TAG/Dockerfile
FROM akabe/iocaml:${TAG}
EOF

if [[ "$OS" =~ ^alpine: ]]; then
    alpine_scripts >> dockerfiles/$TAG/Dockerfile
    SHELL=sh
elif [[ "$OS" =~ ^centos: ]]; then
    centos_scripts >> dockerfiles/$TAG/Dockerfile
    SHELL=bash
elif [[ "$OS" =~ ^debian: ]]; then
    debian_scripts >> dockerfiles/$TAG/Dockerfile
    SHELL=bash
elif [[ "$OS" =~ ^ubuntu: ]]; then
    ubuntu_scripts >> dockerfiles/$TAG/Dockerfile
    SHELL=bash
else
    echo -e "\033[31m[ERROR] Unknown base image: ${OS}\033[0m"
    exit 1
fi
