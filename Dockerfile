FROM alpine
ARG http_proxy
ARG https_proxy
ARG no_proxy
RUN apk update && apk upgrade
# Install Squid.
RUN set -x \
 && apk add --no-cache squid 

RUN if [ ! -z "$http_proxy" ];then\
  proxy_host=$(echo $http_proxy | sed 's|http://||;s|:.*||');\
  proxy_port=$(echo $http_proxy | sed 's/.*://');\ 
  echo cache_peer ${proxy_host} parent ${proxy_port} 0 no-query no-digest >> /etc/squid/squid.conf;\
  echo never_direct allow all >> /etc/squid/squid.conf;\
 fi;

EXPOSE 3128

CMD ["squid", "-N"]
