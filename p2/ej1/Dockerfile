FROM debian:bookworm-slim

WORKDIR /tmp
ADD https://download.redis.io/releases/redis-7.4.2.tar.gz redis.tar.gz

RUN apt-get update \
    && mkdir redis \
    && tar -xzf redis.tar.gz -C redis --strip-components=1 \
    && apt-get install -y wget gcc make \
    && make -C redis \
    && make -C redis install \
    && rm -rf redis redis.tar.gz \
    && apt-get clean \
    && apt-get purge -y --autoremove wget gcc make \
    && groupadd -r redis \
    && useradd -r -g redis redis

ENV REDIS_DATA=/data
WORKDIR /data
RUN chown redis:redis /data
USER redis
EXPOSE 6379/tcp
ENTRYPOINT ["redis-server", "--protected-mode", "no", "--save", "5", "1"]
