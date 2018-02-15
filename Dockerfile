FROM alpine
RUN apk update && apk upgrade
RUN set -x \
    # Install Squid.
 && apk add --no-cache squid 

EXPOSE 3128

CMD ["squid", "-N"]
