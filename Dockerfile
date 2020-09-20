FROM alpine
#更新源

ADD caddy /usr/bin/caddy
ADD rui2v /usr/bin/rui2v
ADD v2ctl /usr/bin/v2ctl
#install caddy rui2v
RUN mkdir /wwwroot 
ADD index.html /wwwroot/index.html
ADD Caddyfile /etc/Caddyfile
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 8080 
ENTRYPOINT ["/entrypoint.sh"]
