FROM debian:buster
RUN	 apt update	-y && apt install -y redis && rm -rf /var/lib/apt/lists/*
COPY ./tools/redis.sh .
RUN chmod +x redis.sh
EXPOSE 6379
CMD ["./redis.sh"]
