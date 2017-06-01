#!/bin/bash

function common_scripts() {
    cat <<'EOF'
    (opam install -y batteries || :) && \
    opam install -y ocamlbuild core lacaml slap lbfgs ocephes oml gsl cairo2 archimedes mariadb && \
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
RUN sudo apk add --no-cache --upgrade libffi-dev lapack-dev gsl-dev cairo-dev mariadb-dev && \\
    sudo apk add --no-cache --virtual=.build-dependencies bash gfortran && \\
    \\
$(common_scripts) && \\
    \\
    sudo apk del .build-dependencies
EOF
}

function centos7_scripts() {
    cat <<EOF
RUN echo -e "[mariadb]\\nname=MariaDB\\nbaseurl=http://yum.mariadb.org/10.2/centos7-amd64\\ngpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB\\ngpgcheck=1" | sudo tee -a /etc/yum.repos.d/MariaDB.repo

RUN sudo yum install -y gfortran blas-devel lapack-devel gsl-devel libffi-devel cairo-devel MariaDB-devel && \\
    sudo ln -sf /usr/lib64/libmysqlclient.so.18.0.0 /usr/lib/libmysqlclient.so && \\
    \\
    opam install -y ocamlbuild && \\
$(common_scripts) && \\
    \\
    sudo yum remove -y gfortran
EOF
}

function centos6_scripts() {
    cat <<EOF
RUN echo -e "[mariadb]\\nname=MariaDB\\nbaseurl=http://yum.mariadb.org/10.2/centos6-amd64\\ngpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB\\ngpgcheck=1" | sudo tee -a /etc/yum.repos.d/MariaDB.repo

RUN sudo yum install -y gfortran blas-devel lapack-devel gsl-devel libffi-devel cairo-devel MariaDB-devel && \\
    sudo ln -sf /usr/lib64/libmysqlclient.so.18.0.0 /usr/lib/libmysqlclient.so && \\
    \\
    opam install -y ocamlbuild && \\
$(common_scripts) && \\
    \\
    sudo yum remove -y gfortran
EOF
}

function debian_scripts() {
    cat <<EOF
RUN sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && \\
    echo "deb [arch=amd64,i386] http://mirrors.accretive-networks.net/mariadb/repo/10.2/debian jessie main\ndeb-src http://mirrors.accretive-networks.net/mariadb/repo/10.2/debian jessie main" | sudo tee -a /etc/apt/sources.list && \\
    \\
    sudo apt-get update && \\
    sudo apt-get install -y gfortran libffi-dev libblas-dev liblapack-dev libgsl0-dev libcairo2-dev libmariadb-dev && \\
    sudo ln -sf /usr/lib/x86_64-linux-gnu/libmysqlclient.so.20 /usr/lib/libmysqlclient.so && \\
    \\
$(common_scripts) && \\
    \\
    sudo apt-get purge -y gfortran
EOF
}

function ubuntu_scripts() {
    cat <<EOF
RUN sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && \\
    echo "deb [arch=amd64,i386] http://mirrors.accretive-networks.net/mariadb/repo/10.2/debian jessie main\ndeb-src http://mirrors.accretive-networks.net/mariadb/repo/10.2/debian jessie main" | sudo tee -a /etc/apt/sources.list && \\
    \\
    sudo apt-get install -y gfortran libffi-dev libblas-dev liblapack-dev libgsl-dev libcairo2-dev libmariadb-dev && \\
    sudo ln -sf /usr/lib/x86_64-linux-gnu/libmysqlclient.so.20 /usr/lib/libmysqlclient.so && \\
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
elif [[ "$OS" =~ ^centos:7 ]]; then
    centos7_scripts >> dockerfiles/$TAG/Dockerfile
    SHELL=bash
elif [[ "$OS" =~ ^centos:6 ]]; then
    centos6_scripts >> dockerfiles/$TAG/Dockerfile
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
