FROM debian:bookworm-slim as builder

WORKDIR /tmp
ADD https://download.redis.io/releases/redis-7.4.2.tar.gz redis.tar.gz
RUN apt-get update \
	&& mkdir redis \
	&& tar -xzf redis.tar.gz -C redis --strip-components=1 \
	&& apt-get install -y wget gcc make \
	&& make	-C redis \
	&& make	-C redis install

FROM frolvlad/alpine-glibc

ENV REDIS_DATA=/data
WORKDIR	$REDIS_DATA 
RUN addgroup -S redis \
	&& adduser -S redis -G redis \
	&& chown redis:redis $REDIS_DATA
USER redis
EXPOSE 6379/tcp
COPY --from=builder /usr/local/bin/redis-cli /usr/local/bin
COPY --from=builder /usr/local/bin/redis-server /usr/local/bin
ENTRYPOINT ["redis-server", "--protected-mode", "no", "--save", "5", "1"]
