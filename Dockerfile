FROM ubuntu:20.04

# Node.js
RUN apt-get update
RUN apt-get install curl -y
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# pip
RUN apt-get install python3-distutils -y
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py

# Racket
ARG RACKET_VERSION=7.7
RUN apt-get install wget -y
RUN wget http://mirror.informatik.uni-tuebingen.de/mirror/racket/$RACKET_VERSION/racket-$RACKET_VERSION-x86_64-linux.sh
RUN chmod +x racket-$RACKET_VERSION-x86_64-linux.sh
RUN ./racket-$RACKET_VERSION-x86_64-linux.sh
RUN echo 'export PATH=$PATH:/usr/racket/bin' >> ~/.bashrc

# gcc
RUN apt-get install gcc -y

# Haskell
RUN apt-get install make
RUN curl https://gitlab.haskell.org/haskell/ghcup/raw/master/bootstrap-haskell -sSf | sh
RUN . "$HOME/.ghcup/env"
RUN echo '. $HOME/.ghcup/env' >> "$HOME/.bashrc"
RUN curl -sSL https://get.haskellstack.org/ | sh
RUN echo 'export PATH=$PATH:/root/.local/bin' >> ~/.bashrc
