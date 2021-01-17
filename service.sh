docker service create --replicas=1 \
    --name xmrig \
    --with-registry-auth \
    --cap-add SYS_ADMIN \
    --mount target=/lib/modules,source=/lib/modules,type=bind \
    localhost:5000/xmrig:latest
