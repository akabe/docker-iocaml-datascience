
#!/bin/bash

function common_scripts() {
    cat <<'EOF'
    (opam install -y batteries || :) && \
    opam install -y core lacaml slap lbfgs ocephes oml gsl cairo2 archimedes mariadb postgresql && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build
EOF
}

function centos_scripts() {
    cat <<'EOF' > dockerfiles/$TAG/MariaDB.repo
[mariadb]
name=MariaDB
baseurl=http://yum.mariadb.org/10.2/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOF

    cat <<EOF > dockerfiles/$TAG/Dockerfile
FROM akabe/iocaml:${TAG}

ADD MariaDB.repo /etc/yum.repos.d/MariaDB.repo

RUN sudo yum install -y gfortran blas-devel lapack-devel gsl-devel libffi-devel cairo-devel MariaDB-devel postgresql-devel && \\
    sudo ln -sf /usr/lib64/libmysqlclient.so.18.0.0 /usr/lib/libmysqlclient.so && \\
    \\
$(common_scripts) && \\
    \\
    sudo yum remove -y gfortran
EOF
}

function debian_scripts() {
    cat <<EOF > dockerfiles/$TAG/Dockerfile
FROM akabe/iocaml:${TAG}

RUN sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && \\
    echo 'deb [arch=amd64,i386] http://mirrors.accretive-networks.net/mariadb/repo/10.2/debian jessie main' | sudo tee -a /etc/apt/sources.list && \\
    sudo apt-get update && \\
    sudo apt-get install -y gfortran libffi-dev libblas-dev liblapack-dev libgsl0-dev libcairo2-dev libmariadb-dev libpq-dev && \\
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

if [[ "$OS" =~ ^centos: ]]; then
    centos_scripts
elif [[ "$OS" =~ ^debian: ]]; then
    debian_scripts
else
    echo -e "\033[31m[ERROR] Unknown base image: ${OS}\033[0m"
    exit 1
fi
