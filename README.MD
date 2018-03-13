# Bitcoind-interest 

**Up and running full node**


Bitcoin Interest ("BCI") is a competitive staking cryptocurrency focusing on three key areas Technology, Community, and Savings. 


## Getting Started 

* Modify bitcoin.conf
```
docker build -t bitcoind-interest .
``` 


* Provision data directory. default: /data-node

```
docker run -d --name bitcoin-interest
--volume /data-node:/data-node
-p 8332:8332 \
--publish 8333:8333 \
andrewpsp/bitcoind-interest

```


## Bugs and Issues

Have a bug or an issue with this template? Open a new issue [here](https://github.com/andrewpsp/bitcoind-interest/issues) on GitHub or leave a comment on the [twitter](https://www.twitter.com/andrewpsp)