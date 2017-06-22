#!/bin/bash

function common_scripts() {
    cat <<'EOF'
    opam update && \
    (opam install -y batteries || :) && \
    opam install -y \
      num \
      'core>=v0.9.0' \
      lacaml \
      slap \
      lbfgs \
      ocephes \
      oml \
      gsl \
      fftw3 \
      'cairo2>=0.5' \
      archimedes \
      mysql \
      'mariadb>=0.8.1' \
      postgresql \
      sqlite3 \
      ocurl \
      'oasis>=0.4.0' && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    eval $(opam config env) && \
    \
    : install libsvm && \
    curl -L https://bitbucket.org/ogu/libsvm-ocaml/downloads/libsvm-ocaml-0.9.3.tar.gz \
         -o /tmp/libsvm-ocaml-0.9.3.tar.gz && \
    tar zxf /tmp/libsvm-ocaml-0.9.3.tar.gz -C /tmp && \
    ( \
      cd /tmp/libsvm-ocaml-0.9.3 && \
      oasis setup && \
      ./configure --prefix=$(opam config var prefix) && \
      make && \
      make install \
    ) && \
    rm -rf /tmp/libsvm-ocaml-0.9.3.tar.gz /tmp/libsvm-ocaml-0.9.3 && \
    \
    opam uninstall oasis
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

RUN sudo yum -y install epel-release && \\
    sudo rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm && \\
    sudo yum install -y --enablerepo=epel,nux-dextop \\
      gfortran \\
      openssh-clients \\
      blas-devel \\
      lapack-devel \\
      gsl-devel \\
      libffi-devel \\
      fftw-devel \\
      libsvm-devel \\
      cairo-devel \\
      MariaDB-devel \\
      postgresql-devel \\
      sqlite-devel \\
      libcurl-devel \\
      ImageMagick \\
      ffmpeg && \\
    sudo ln -sf /usr/lib64/libmysqlclient.so.18.0.0 /usr/lib/libmysqlclient.so && \\
    \\
$(common_scripts) && \\
    \\
    sudo yum remove -y gfortran

ADD custom.css /home/opam/.jupyter/custom/custom.css
ADD notebook.json /home/opam/.jupyter/nbconfig/notebook.json
EOF
}

function debian_scripts() {
	cat <<'EOF' > dockerfiles/$TAG/iocaml-datascience-extra.list
deb http://ftp.uk.debian.org/debian jessie-backports main
deb [arch=amd64,i386] http://mirrors.accretive-networks.net/mariadb/repo/10.2/debian jessie main
EOF

	cat <<EOF > dockerfiles/$TAG/Dockerfile
FROM akabe/iocaml:${TAG}

ADD iocaml-datascience-extra.list /etc/apt/sources.list.d/iocaml-datascience-extra.list

RUN sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && \\
    sudo apt-get update && \\
    sudo apt-get install -y \\
      gfortran \\
      ssh \\
      libffi-dev \\
      libblas-dev \\
      liblapack-dev \\
      libgsl0-dev \\
      libfftw3-dev \\
      libsvm-dev \\
      libcairo2-dev \\
      libmariadb-dev \\
      libpq-dev \\
      libsqlite3-dev \\
      libcurl4-openssl-dev \\
      imagemagick \\
      ffmpeg && \\
    sudo ln -sf /usr/lib/x86_64-linux-gnu/libmysqlclient.so.20 /usr/lib/libmysqlclient.so && \\
    \\
$(common_scripts) && \\
    \\
    sudo apt-get purge -y gfortran

ADD custom.css /home/opam/.jupyter/custom/custom.css
ADD notebook.json /home/opam/.jupyter/nbconfig/notebook.json
EOF
}

echo "Generating dockerfiles/$TAG/Dockerfile (ALIAS=${ALIAS[@]})..."

rm -rf dockerfiles/$TAG
mkdir -p dockerfiles/$TAG

cat <<'EOF' > dockerfiles/$TAG/custom.css
@font-face {
  font-family: "Ricty Diminished Discord";
  src: local("Ricty Diminished Discord");
}
@font-face {
  font-family: "Ricty Diminished";
  src: local("Ricty Diminished");
}

.CodeMirror pre, .output pre {
  font-family: "Ricty Diminished Discord", "Ricty Diminished", "Lucida Console", Monaco, monospace;
}
EOF

cat <<'EOF' > dockerfiles/$TAG/notebook.json
{
  "CodeCell": {
    "cm_config": {
      "indentUnit": 2,
      "lineNumbers": true,
      "autoCloseBrackets": true
    }
  }
}
EOF

if [[ "$OS" =~ ^centos: ]]; then
    centos_scripts
elif [[ "$OS" =~ ^debian: ]]; then
    debian_scripts
else
    echo -e "\033[31m[ERROR] Unknown base image: ${OS}\033[0m"
    exit 1
fi
