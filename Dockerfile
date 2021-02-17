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
ARG RACKET_VERSION=8.0
RUN apt-get install wget -y
RUN wget https://mirror.racket-lang.org/installers/$RACKET_VERSION/racket-$RACKET_VERSION-x86_64-linux-cs.sh
RUN chmod +x racket-$RACKET_VERSION-x86_64-linux-cs.sh
RUN ./racket-$RACKET_VERSION-x86_64-linux-cs.sh
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

# Java
ARG JDK_VERSION=11.0.10_9
RUN wget https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.10%2B9/OpenJDK11U-jdk_x64_linux_hotspot_$JDK_VERSION.tar.gz
RUN tar -xf OpenJDK11U-jdk_x64_linux_hotspot_$JDK_VERSION.tar.gz
RUN echo 'export JAVA_HOME=/jdk-11.0.10+9' >> ~/.bashrc
RUN echo 'export PATH=$PATH:$JAVA_HOME/bin' >> ~/.bashrc

# Maven
ARG MAVEN_VERSION=3.6.3
RUN wget https://mirrors.gigenet.com/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz
RUN tar -xf apache-maven-$MAVEN_VERSION-bin.tar.gz
RUN echo 'export PATH=$PATH:/apache-maven-3.6.3/bin' >> ~/.bashrc
