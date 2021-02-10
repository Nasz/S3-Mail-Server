FROM alpine:3.13

RUN apk update && \
    apk upgrade && \
    apk add opendkim runit socklog && \
    apk add postfix runit socklog tzdata ca-certificates && \
    apk add dovecot dovecot-lmtpd runit socklog ca-certificates && \
    rm -rf /etc/service

# tzdata - for passing TZ environment variable.
# socklog - collect all logs which come to /dev/log.

COPY service /etc/service
ENTRYPOINT runsvdir -P /etc/service
#ENTRYPOINT chpst -Unobody socklog unix /dev/log & postfix start-fg
