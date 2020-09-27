# mysql backup image
FROM alpine:3.12

# install the necessary client
# the mysql-client must be 10.3.15 or later
RUN mkdir /docker-entrypoint-initdb.d && \
    apk -U upgrade && \
    apk add --no-cache mariadb-client mariadb-connector-c bash python3 samba-client shadow openssl py-pip && \
	pip3 install --upgrade pip && \
    rm -rf /var/cache/apk/*
	
RUN rm -rf /var/cache/apk/* && \
    touch /etc/samba/smb.conf && \
    pip3 install awscli


# install the entrypoint
COPY functions.sh /
COPY entrypoint /entrypoint

# start
ENTRYPOINT ["/entrypoint"]
