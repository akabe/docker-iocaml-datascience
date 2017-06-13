FROM akabe/iocaml:centos7_ocaml4.03.0

ADD MariaDB.repo /etc/yum.repos.d/MariaDB.repo

RUN sudo yum install -y gfortran blas-devel lapack-devel gsl-devel libffi-devel cairo-devel MariaDB-devel postgresql-devel && \
    sudo ln -sf /usr/lib64/libmysqlclient.so.18.0.0 /usr/lib/libmysqlclient.so && \
    \
    (opam install -y batteries || :) && \
    opam install -y core lacaml slap lbfgs ocephes oml gsl cairo2 archimedes mariadb postgresql && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    sudo yum remove -y gfortran
