
FROM ubuntu

LABEL author=Andrew\ Thompson \
      bitcoin.Project=bitcoind-intrest \
      bitcoin.Client="bitcoind" \
      bitcoin.version="0.0.1" \
      bitcoin.release-date="2018-3-11"


#add personal 
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8842ce5e && \
    echo "deb http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu xenial main" \
    > /etc/apt/sources.list.d/bitcoin.list
RUN apt-get update -y && \
    apt-get install -y bitcoind && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#location of ledger and defaults for bitcoin.conf overide with CLI arugments 

ENV BITCOIN_DIR=/data-node
ENV BITCOIN_CONF=${BITCOIN_DIR}/bitcoin.conf 
ENV HOME /data-node
ENV BTC_RPCUSER=bci' 
ENV BTC_RPCPASSWORD=admin'
ENV BTC_TXINDEX=1' 
ENV BTC_RPCUSER	bci
ENV BTC_RPCPASSWORD	password
ENV BTC_RPCPORT	8332
ENV BTC_RPCALLOWIP 0.0.0.0/0
ENV BTC_RPCCLIENTTIMEOUT 30
ENV BTC_DISABLEWALLET 1
ENV BTC_TXINDEX	1



COPY . ${BITCOIN_DIR}/

VOLUME ["/data-node"]

EXPOSE 8332 8333

WORKDIR /data-node

ENTRYPOINT ["bitcoind", "-datadir=${BITCOIN_DIR}", "-conf=${BITCOIN_CONF}"]
