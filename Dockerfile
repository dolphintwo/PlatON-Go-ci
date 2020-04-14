FROM golang:1.13.10-stretch AS builder
WORKDIR /src
RUN apt update \
    && apt install -y cmake llvm g++ libgmp-dev libssl-dev
COPY . .
RUN find /src/build -name "*.sh" -exec chmod u+x {} \;
RUN make all

FROM debian:stretch-slim
WORKDIR /data
RUN apt update \
	&& apt install -y --no-install-recommends libgmp-dev libssl-dev \
    && rm -rf /var/lib/apt/lists/*
COPY --from=builder /src/build/bin/platon /usr/local/bin
VOLUME ["/data"]
EXPOSE 6789 16789
CMD [ "--identity", "platon", "--testnet", "--rpc", "--rpcapi", "db,platon,net,web3,admin,personal" ]
ENTRYPOINT [ "platon","--datadir", "/data"]