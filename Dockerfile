FROM ubuntu:14.04

ENV HOME /app

ENV LANG en_US.UTF-8
RUN locale-gen en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository ppa:hvr/ghc -y
RUN apt-get update
RUN apt-get install -y ghc-7.8.4 cabal-install-1.20 alex-3.1.4 happy-1.19.5 zlib1g-dev wget
ENV PATH /opt/ghc/7.8.4/bin:/opt/cabal/1.20/bin:/opt/alex/3.1.4/bin:/opt/happy/1.19.5/bin:/usr/bin:/bin

ADD ./docker/ /app/
WORKDIR /app/
RUN wget https://www.stackage.org/lts/cabal.config
RUN cabal update
RUN cabal sandbox init
RUN cabal install -j

CMD /app/.cabal/bin/soh-test-docker
