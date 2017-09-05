# [akabe/iocaml-datascience](https://hub.docker.com/r/akabe/iocaml-datascience/)

# **Deprecated**: this Dockerfile is no longer maintained. Please use [akabe/ocaml-jupyter-datascience](https://github.com/akabe/docker-ocaml-jupyter-datascience) instead.

| Travis CI | MicroBadger |
| --- | --- |
| [![Build Status](https://travis-ci.org/akabe/docker-iocaml-datascience.svg?branch=master)](https://travis-ci.org/akabe/docker-iocaml-datascience) | [![Image Status](https://images.microbadger.com/badges/image/akabe/iocaml-datascience.svg)](https://microbadger.com/images/akabe/iocaml-datascience) |

A ready-to-use environment of [Jupyter](http://ipython.org/notebook.html) (IPython notebook) and [IOCaml](https://github.com/andrewray/iocaml) ([OCaml](https://ocaml.org/) kernel) with libraries for data science and machine learning.

## Getting started

First, launch a Jupyter server as follows.

```console
$ docker run --name iocaml -it -p 8888:8888 akabe/iocaml-datascience
[I 15:38:04.170 NotebookApp] Writing notebook server cookie secret to /home/opam/.local/share/jupyter/runtime/notebook_cookie_secret
[W 15:38:04.190 NotebookApp] WARNING: The notebook server is listening on all IP addresses and not using encryption. This is not recommended.
[I 15:38:04.197 NotebookApp] Serving notebooks from local directory: /notebooks
[I 15:38:04.197 NotebookApp] 0 active kernels
[I 15:38:04.197 NotebookApp] The Jupyter Notebook is running at: http://[all ip addresses on your system]:8888/?token=4df0fee0719115f474c8dd9f9281abed28db140d25f933e9
[I 15:38:04.197 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[W 15:38:04.198 NotebookApp] No web browser found: could not locate runnable browser.
[C 15:38:04.198 NotebookApp]

    Copy/paste this URL into your browser when you connect for the first time,
    to login with a token:
        http://localhost:8888/?token=4df0fee0719115f474c8dd9f9281abed28db140d25f933e9
```

Second, access to the URL at the above last line to your web browser, then

![Screenshot of Jupyter with IOCaml](screenshot.png)

You can create OCaml notebooks!

Notebooks on your host machine can be mounted to a Docker container like

```
docker run --name iocaml -it -p 8888:8888 -v $PWD:/notebooks akabe/iocaml-datascience
```

## Distributions

The default images are built on Debian 8:

| Tag | OCaml | OPAM | Command | Dockerfile |
| ------------ | ----- | ---- | ------- | ---------- |
| **latest** | 4.04.1 | 1.2.2 | `docker pull akabe/iocaml-datascience` | [Dockerfile](dockerfiles/debian8_ocaml4.04.1/Dockerfile) |
| 4.05.0 | 4.05.0+trunk | 1.2.2 | `docker pull akabe/iocaml-datascience:4.05.0` | [Dockerfile](dockerfiles/debian8_ocaml4.05.0/Dockerfile) |
| 4.04.1 | 4.04.1 | 1.2.2 | `docker pull akabe/iocaml-datascience:4.04.1` | [Dockerfile](dockerfiles/debian8_ocaml4.04.1/Dockerfile) |

### CentOS

| Distribution | OCaml | OPAM | Command | Dockerfile |
| ------------ | ----- | ---- | ------- | ---------- |
| CentOS 7 | 4.05.0+trunk | 1.2.2 | `docker pull akabe/iocaml-datascience:centos7_ocaml4.05.0` | [Dockerfile](dockerfiles/centos7_ocaml4.05.0/Dockerfile) |
| CentOS 7 | 4.04.1 | 1.2.2 | `docker pull akabe/iocaml-datascience:centos7_ocaml4.04.1` | [Dockerfile](dockerfiles/centos7_ocaml4.04.1/Dockerfile) |

### Debian

| Distribution | OCaml | OPAM | Command | Dockerfile |
| ------------ | ----- | ---- | ------- | ---------- |
| Debian 8 | 4.05.0+trunk | 1.2.2 | `docker pull akabe/iocaml-datascience:debian8_ocaml4.05.0` | [Dockerfile](dockerfiles/debian8_ocaml4.05.0/Dockerfile) |
| Debian 8 | 4.04.1 | 1.2.2 | `docker pull akabe/iocaml-datascience:debian8_ocaml4.04.1` | [Dockerfile](dockerfiles/debian8_ocaml4.04.1/Dockerfile) |

## Pre-installed packages

### Standard libraries

The OCaml standard library is too small in practical use.
The following packages provide popular data structures, a lot of frequently-used functions such as string operations,
complex iteration on collections, etc.

- **[Jane Street Core](https://janestreet.github.io/)** ([GitHub](https://github.com/janestreet/core), [API](https://ocaml.janestreet.com/ocaml-core/v0.9/doc/core/Core/)) &mdash; A huge extended standard library developed by Jane Street Capital. The library is actively maintained and reliable due to industrial use of Jane Street. Its interface is designed differently from the OCaml standard library.
- **[Batteries Included](http://batteries.forge.ocamlcore.org/)** ([GitHub](https://github.com/ocaml-batteries-team/batteries-included), [API](http://ocaml-batteries-team.github.io/batteries-included/hdoc2/)) &mdash; A famous extended standard library compatible with the OCaml standard library. It is smaller than Jane Street Core, but commonly-used functions are implemented.

### Numerical computation

- **[Lacaml](http://mmottl.github.io/lacaml/)** ([GitHub](https://github.com/mmottl/lacaml), [API](http://mmottl.github.io/lacaml/API.docdir/)) &mdash; A binding to [BLAS](http://www.netlib.org/blas/) (Basic Linear Algebra Subprograms) and [LAPACK](http://www.netlib.org/lapack/) (Linear Algebra PACKage), traditional linear algebra libraries written in Fortran. This library supplies basic operations on vectors and matrices (e.g., addition, dot product, multiplication), LU, QR, SVD, least-square fitting, etc.
- **[SLAP](http://akabe.github.io/slap/)** ([GitHub](https://github.com/akabe/slap), [API](http://akabe.github.io/slap/api/)) &mdash; A high-level wrapper of Lacaml with type-based static size checks for vectors and matrices.
    - [examples/slap_two_layer_neural_network.ipynb](examples/slap_two_layer_neural_network.ipynb)
- **[GSL](http://mmottl.github.io/gsl-ocaml)** ([GitHub](https://github.com/mmottl/gsl-ocaml), [API](http://mmottl.github.io/gsl-ocaml/api/)) &mdash; A binding to [GNU Scientific Library (GSL)](http://www.gnu.org/software/gsl/), a rich numerical analysis library containing interface to BLAS. This library contains eigenproblem solvers, least square fitting, pseudo-random number generators (such as Mersenne Twister), FFT (fast Fourier transform), Monte-Carlo simulation, etc.
    - [examples/gaussian_random_walk.ipynb](examples/gaussian_random_walk.ipynb)
    - [examples/random_dataset_generation.ipynb](examples/random_dataset_generation.ipynb)
- **FFTW3** ([GitHub](https://github.com/Chris00/fftw-ocaml)) &mdash; A binding to [FFTW3](http://fftw.org/), a major fast Fourier transform library.
    - [examples/fftw3_example.ipynb](examples/fftw3_example.ipynb)
- **libsvm** ([BitBucket](https://bitbucket.org/ogu/libsvm-ocaml/), [API](https://ogu.bitbucket.io/libsvm-ocaml/api/)) &mdash; Support vector machine (SVM) is a powerful model in machine learning. This is a binding to [libsvm](https://www.csie.ntu.edu.tw/~cjlin/libsvm/), a library for SVMs.
- **TensorFlow** ([GitHub](https://github.com/LaurentMazare/tensorflow-ocaml)) &mdash; A binding to [TensorFlow](https://www.tensorflow.org/), a popular open-source neural network library developed by Google.
- **[L-BFGS](https://github.com/Chris00/L-BFGS-ocaml)** ([API](http://lbfgs.forge.ocamlcore.org/API.docdir/Lbfgs.html)) &mdash; A binding to [L-BFGS-B](http://users.iems.northwestern.edu/~nocedal/lbfgsb.html), a quasi-Newton library for bound-constrained optimization.
- **Ocephes** ([GitHub](https://github.com/rleonid/ocephes), [API](https://rleonid.github.io/ocephes/)) &mdash; A binding to [Ocephes](http://www.netlib.org/cephes/), a library of special math functions like Binominal, Gaussian, Gamma distributions, incomplete Beta integral.
- **[Oml](http://www.hammerlab.org/2015/08/11/introducing-oml-a-small-ocaml-library-for-numerical-computing/)** ([GitHub](https://github.com/hammerlab/oml), [API](http://www.hammerlab.org/oml/index.html)) &mdash; A small library for numerical computing on OCaml.
- **[GPR](https://mmottl.github.io/gpr/)** ([GitHub](https://github.com/mmottl/gpr), [API](http://mmottl.github.io/gpr/api/). [PDF](http://mmottl.github.io/gpr/gpr_manual.pdf)) &mdash; Efficient and scalable Gaussian Process Regression in OCaml.

### Visualization

- **[Archimedes](http://archimedes.forge.ocamlcore.org/)** ([API](http://archimedes.forge.ocamlcore.org/API/Archimedes.html)) &mdash; A 2D plot library like matplotlib in Python. You can embed PNG images in Jupyter notebooks.
    - [examples/archimedes_iocaml.ipynb](examples/archimedes_iocaml.ipynb)
- **Cairo2** ([GitHub](https://github.com/Chris00/ocaml-cairo), [Tutorial](http://cairo.forge.ocamlcore.org/tutorial/index.html), [API](http://cairo.forge.ocamlcore.org/tutorial/Cairo.html)) &mdash; A binding to [Cairo](https://cairographics.org/), a 2D vector graphics library. This library is useful as a backend of Archimedes.

### Data sources

- **[MySQL](http://ygrek.org.ua/p/ocaml-mysql/)** ([GitHub](https://github.com/ygrek/ocaml-mysql), [API](http://ygrek.org.ua/p/ocaml-mysql/api/index.html)) &mdash; A well-benchmarked MySQL client library providing blocking API.
    - [examples/mysql_over_ssh_tunnel.ipynb](examples/mysql_over_ssh_tunnel.ipynb)
- **MariaDB** ([GitHub](https://github.com/andrenth/ocaml-mariadb)) &mdash; [MariaDB](https://mariadb.org/) is a rich relational database management system compatible with MySQL. This client library provides blocking and nonblocking (Lwt and Async) interfaces that can connect both of MySQL and MariaDB.
- **[Postgresql](http://mmottl.github.io/postgresql-ocaml/)** ([GitHub](https://github.com/mmottl/postgresql-ocaml), [API](http://mmottl.github.io/postgresql-ocaml/api/)) &mdash; [PostgreSQL](https://www.postgresql.org/) is a popular relational database with many aggregate and window functions useful for data analysis.
- **[SQLite3](http://mmottl.github.io/sqlite3-ocaml/)** ([GitHub](https://github.com/mmottl/sqlite3-ocaml), [API](http://mmottl.github.io/sqlite3-ocaml/API.docdir/)) &mdash; A client library for SQLite3, a easy-to-use lightweight database.
- **Cohttp** ([GitHub](https://github.com/mirage/ocaml-cohttp), [API](http://mirage.github.io/ocaml-cohttp/)) &mdash; A very lightweight HTTP(s) client/server library using Async and Lwt. This library is useful to access to API servers or Web scraping.
    - [examples/cohttp_async_example.ipynb](examples/cohttp_async_example.ipynb)
    - [examples/cohttp_lwt_example.ipynb](examples/cohttp_lwt_example.ipynb)
- **[ocurl](http://ygrek.org.ua/p/ocurl/)** ([GitHub](https://github.com/ygrek/ocurl), [API](http://ygrek.org.ua/p/ocurl/api/index.html)) &mdash; A binding to libcurl, a popular easy-to-use HTTP(S) client library. This library is useful to access to API servers or Web scraping.
    - [examples/ocurl_example.ipynb](examples/ocurl_example.ipynb)

### Concurrent programming

- **[Jane Street Async](https://janestreet.github.io/)** ([GitHub](https://github.com/janestreet/async), [API](https://ocaml.janestreet.com/ocaml-core/v0.9/doc/async/Async/index.html)) &mdash; Jane Street Capital's library for concurrent programming.
    - [examples/animation.ipynb](examples/animation.ipynb)
- **[Lwt](https://ocsigen.org/lwt/manual/)** ([GitHub](https://github.com/ocsigen/lwt), [API](https://ocsigen.org/lwt/3.0.0/api/Lwt)) &mdash; A library of cooperative light-weight threads.

### CUI tools

- **[ImageMagick](https://www.imagemagick.org/script/index.php)** &mdash; ImageMagick is a program to create, edit, compose, or convert bitmap images. This supports many formats, e.g., PNG, JPEG, GIF, TIFF, PDF, etc.
- **[FFmpeg](https://ffmpeg.org/)** &mdash; FFmpeg is a powerful tool for converting audio and video files.

## Examples

```
git clone git@github.com:akabe/docker-iocaml-datascience.git
docker run --name iocaml -it -p 8888:8888 -v $PWD/docker-iocaml-datascience/examples:/notebooks akabe/iocaml-datascience
```

- [Formant Estimation by AR model](examples/formant_estimation_by_AR.ipynb) &mdash;
  [Formant](https://en.wikipedia.org/wiki/Formant) is a peak of power spectrum of human voice. This example is fundamental of speech recognition and voice synthesis.

## Contribution

If you know a widely-used numerical library in OCaml, find a bug, or have an idea to improve this environment, please create an issue or pull-request your changes.
