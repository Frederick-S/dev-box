FROM ubuntu:20.04

# Node.js
RUN apt-get update
RUN apt-get install curl -y
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# Pip
RUN apt-get install python3-distutils -y
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py
RUN rm get-pip.py

# Racket
ARG RACKET_VERSION=8.0
RUN apt-get install wget -y
RUN wget https://mirror.racket-lang.org/installers/$RACKET_VERSION/racket-$RACKET_VERSION-x86_64-linux-cs.sh
RUN chmod +x racket-$RACKET_VERSION-x86_64-linux-cs.sh
RUN ./racket-$RACKET_VERSION-x86_64-linux-cs.sh
RUN rm racket-$RACKET_VERSION-x86_64-linux-cs.sh
RUN echo 'export PATH=$PATH:/usr/racket/bin' >> ~/.bashrc

# Gcc
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
RUN rm OpenJDK11U-jdk_x64_linux_hotspot_$JDK_VERSION.tar.gz
RUN echo 'export JAVA_HOME=/jdk-11.0.10+9' >> ~/.bashrc
RUN echo 'export PATH=$PATH:$JAVA_HOME/bin' >> ~/.bashrc

# Maven
ARG MAVEN_VERSION=3.6.3
RUN wget https://mirrors.gigenet.com/apache/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz
RUN tar -xf apache-maven-$MAVEN_VERSION-bin.tar.gz
RUN rm apache-maven-$MAVEN_VERSION-bin.tar.gz
RUN mv apache-maven-$MAVEN_VERSION apache-maven
RUN echo 'export PATH=$PATH:/apache-maven/bin' >> ~/.bashrc

# Go
RUN wget https://golang.org/dl/go1.16.linux-amd64.tar.gz
RUN tar -xf go1.16.linux-amd64.tar.gz
RUN rm go1.16.linux-amd64.tar.gz
RUN echo 'export PATH=$PATH:/go/bin' >> ~/.bashrc

# Ruby
RUN apt-get install ruby-full -y

# .NET
RUN wget https://download.visualstudio.microsoft.com/download/pr/a2052604-de46-4cd4-8256-9bc222537d32/a798771950904eaf91c0c37c58f516e1/dotnet-sdk-5.0.103-linux-x64.tar.gz
RUN mkdir dotnet
RUN tar -xf dotnet-sdk-5.0.103-linux-x64.tar.gz -C dotnet
RUN rm dotnet-sdk-5.0.103-linux-x64.tar.gz
RUN echo 'export PATH=$PATH:/dotnet' >> ~/.bashrc
RUN echo 'export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1' >> ~/.bashrc
