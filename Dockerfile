FROM alpine:latest

RUN apk update && apk add curl && rm -rf /var/cache/apk/*

CMD [ "/discoveryserver" ]
COPY --from=discoveryserver /discoveryserver /discoveryserver
