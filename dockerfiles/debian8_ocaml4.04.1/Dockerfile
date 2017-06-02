FROM akabe/iocaml:debian8_ocaml4.04.1
RUN sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && \
    echo "deb [arch=amd64,i386] http://mirrors.accretive-networks.net/mariadb/repo/10.2/debian jessie main\ndeb-src http://mirrors.accretive-networks.net/mariadb/repo/10.2/debian jessie main" | sudo tee -a /etc/apt/sources.list && \
    \
    sudo apt-get update && \
    sudo apt-get install -y gfortran libffi-dev libblas-dev liblapack-dev libgsl0-dev libcairo2-dev libmariadb-dev && \
    sudo ln -sf /usr/lib/x86_64-linux-gnu/libmysqlclient.so.20 /usr/lib/libmysqlclient.so && \
    \
    (opam install -y batteries || :) && \
    opam install -y ocamlbuild core lacaml slap lbfgs ocephes oml gsl cairo2 archimedes mariadb && \
    \
    find $HOME/.opam -regex '.*\.\(cmt\|cmti\|annot\|byte\)' -delete && \
    rm -rf $HOME/.opam/archives \
           $HOME/.opam/repo/default/archives \
           $HOME/.opam/$OCAML_VERSION/man \
           $HOME/.opam/$OCAML_VERSION/build && \
    \
    sudo apt-get purge -y gfortran
