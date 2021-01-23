docker run --name xmrig \
    --privileged --cap-add SYS_ADMIN \
    --restart=on-failure:20 \
    --mount target=/lib/modules,source=/lib/modules,type=bind \
    --volume "$(pwd)"/src/config:/etc/config \
    xmrig:latest
