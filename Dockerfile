FROM alpine:3.5
WORKDIR /root
RUN apk add --no-cache autossh mysql-client
ADD ssh-tunnel.sh /root
CMD exec /root/ssh-tunnel.sh
