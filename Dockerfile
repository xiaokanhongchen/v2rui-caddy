FROM alpine
#更新源

ADD ./ ./
#install caddy rui2v
RUN mv caddy rui2v v2ctl /usr/bin \
 && chmod +x /usr/bin/caddy /usr/bin/v2ctl /usr/bin/rui2v \
 && mkdir /wwwroot \
 && mv index.html /wwwroot/index.html \
 && mv Caddyfile /etc/Caddyfile

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 8080 
ENTRYPOINT ["/entrypoint.sh"]
