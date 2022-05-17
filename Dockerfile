FROM alpine:3.6

ENV VER=2.11.2 METHOD=chacha20 PASSWORD=ss123456
ENV TLS_PORT=4433 PORT=8080

RUN apk add --no-cache curl \
  && curl -sL https://github.com/omdbsd/gst-hrk/releases/download/v${VER}/gst_${VER}_linux_amd64.tar.gz | tar zx \
  && mv gst_${VER}_linux_amd64 gst && chmod a+x gst/gst

WORKDIR /gst
EXPOSE ${TLS_PORT} $PORT

CMD exec /gst/gst -L=ss+mwss://$METHOD:$PASSWORD@:$TLS_PORT -L=ss+mws://$METHOD:$PASSWORD@:$PORT
