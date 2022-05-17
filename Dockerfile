FROM alpine:3.6

ENV VER=2.11.2 METHOD=cast5-cfb PASSWORD=34abcd12
ENV TLS_PORT=4433 PORT=8080

RUN apk add --no-cache curl \
  && curl -sL https://github.com/omdbsd/gst-hrk/releases/download/v${VER}/gst-linux-amd64-${VER}.tar.gz | tar zvxf \
  && mv gst-linux-amd64-${VER} gst && chmod a+x gst/gst

WORKDIR /gst
EXPOSE ${TLS_PORT} $PORT

CMD exec /gst/gst -L=ss+mwss://$METHOD:$PASSWORD@:$TLS_PORT -L=ss+mws://$METHOD:$PASSWORD@:$PORT
