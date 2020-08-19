FROM centos:7
RUN yum update -y\
    && yum install -y git \
    && yum install -y autoconf automake libtool numactl-devel tcl make daxctl-devel ndctl-devel
RUN git clone https://github.com/pmem/pmem-redis.git
WORKDIR /pmem-redis
RUN git submodule init \
    && git submodule update
RUN make USE_NVM=yes AEP_COW=yes SUPPORT_PBA=yes USE_AOFGUARD=yes
RUN cp -f ./src/redis-server /usr/local/bin/redis-server \
    && cp -f ./src/redis-cli /usr/local/bin/redis-cli \
    && cp -f ./src/redis-sentinel /usr/local/bin/redis-sentinel \
    && cp -f ./src/redis-benchmark /usr/local/bin/redis-benchmark \
    && mkdir -p /etc/redis \
    && cp -f *.conf /etc/redis
EXPOSE 6379
COPY start_redis.sh /pmem-redis/
RUN chmod +x /pmem-redis/start_redis.sh
ENTRYPOINT ["/pmem-redis/start_redis.sh"]
CMD ["yes"]
