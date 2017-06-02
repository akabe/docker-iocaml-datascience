FROM akabe/iocaml:centos6_ocaml4.03.0
RUN echo -e "[mariadb]\nname=MariaDB\nbaseurl=http://yum.mariadb.org/10.2/centos6-amd64\ngpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB\ngpgcheck=1" | sudo tee -a /etc/yum.repos.d/MariaDB.repo

RUN sudo yum install -y gfortran blas-devel lapack-devel gsl-devel libffi-devel cairo-devel MariaDB-devel && \
    sudo ln -sf /usr/lib64/libmysqlclient.so.18.0.0 /usr/lib/libmysqlclient.so && \
    \
    opam install -y ocamlbuild && \
    (opam install -y batteries || :) && \
    opam install -y ocamlbuild core lacaml slap lbfgs ocephes oml gsl cairo2 archimedes mariadb && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    sudo yum remove -y gfortran
