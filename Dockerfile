
FROM ubuntu

LABEL author=Andrew\ Thompson \
      bitcoin.Project=bitcoind-intrest \
      bitcoin.Client="bitcoind" \
      bitcoin.version="0.0.2" \
      bitcoin.release-date="2018-3-20"

WORKDIR /data-node

#To build BCI 
RUN apt-get update -y && \ 
apt-get install -y wget git-core \
build-essential \ 
libtool \ 
autotools-dev \ 
automake \ 
pkg-config \ 
libssl-dev \ 
libevent-dev bsdmainutils \
libboost-all-dev \ 
software-properties-common && \ 
add-apt-repository ppa:bitcoin/bitcoin && \
apt-get update -y 

RUN apt-get update -y && \
apt-get install -y libdb4.8-dev \ 
libdb4.8++-dev \
libminiupnpc-dev \
libzmq3-dev \
libqt5gui5 \ 
libqt5core5a \ 
libqt5dbus5 \ 
qttools5-dev \ 
qttools5-dev-tools \ 
libprotobuf-dev \ 
protobuf-compiler \
libqrencode-dev && \
wget http://de.archive.ubuntu.com/ubuntu/pool/universe/libs/libsodium/libsodium-dev_1.0.13-1_amd64.deb && \
wget http://de.archive.ubuntu.com/ubuntu/pool/universe/libs/libsodium/libsodium18_1.0.13-1_amd64.d && \
dpkg -i libsodium*deb && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  libsodium*deb


#location of ledger and defaults for bitcoin.conf overide with CLI arugments 

ENV BITCOIN_DIR=/data-node
ENV BITCOIN_CONF ${BITCOIN_DIR}/bitcoin.conf 
ENV HOME /data-node
ENV BTC_RPCUSER bci
ENV BTC_RPCPASSWORD bci 
ENV BTC_RPCPORT 8332
ENV BTC_RPCALLOWIP 0.0.0.0/0
ENV BTC_RPCCLIENTTIMEOUT 30
ENV BTC_DISABLEWALLET 0
ENV BTC_TXINDEX	1



COPY . ${BITCOIN_DIR}/

RUN git clone https://github.com/BitcoinInterestOfficial/BitcoinInterest.git && \
chmod -R 777 BitcoinInterest && \
cd BitcoinInterest && \
chmod +x share/genbuild.sh && \ 
./autogen.sh && \ 
./configure && \
chmod -R 777 ../BitcoinInterest && \
make && \
make test && \ 
make install && \
ldconfig && \
cp bcid /usr/bin && chmod +x /usr/bin/bcid && \ 
cp bci-cli /usr/bin && chmod +x /usr/bin/bci-cli


VOLUME ["/data-node"]

EXPOSE 8332 8333

WORKDIR /data-node

ENTRYPOINT ["bcid", "-conf=${BITCOIN_CONF}"]

RUN bci-cli -conf=${BITCOIN_CONF}
