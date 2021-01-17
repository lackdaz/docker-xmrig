docker run --name xmrig \
    --privileged --cap-add SYS_ADMIN \
    --restart=on-failure:20 \
    --mount target=/lib/modules,source=/lib/modules,type=bind \
    localhost:5000/xmrig:latest
