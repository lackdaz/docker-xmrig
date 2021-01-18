FROM ubuntu:20.04 as build

ADD src /src

WORKDIR /src/xmrig/build

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y git build-essential cmake \
    libuv1-dev libssl-dev libhwloc-dev apt-utils \
    && rm -rf /var/lib/apt

RUN cmake .. && make -j$(nproc)

FROM ubuntu:20.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y libuv1-dev libssl-dev libhwloc-dev kmod

COPY --from=build /src/xmrig/build/xmrig /usr/local/bin/xmrig
COPY --from=build /src/xmrig/scripts/randomx_boost.sh /src/randomx_boost.sh

# ADD /src/config/amd64.config.json /etc/xmrig/amd64.config.json

CMD bash /src/randomx_boost.sh && xmrig --threads $(expr $(nproc) - 1) -c /etc/config/amd64.config.json
