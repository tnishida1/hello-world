FROM alpine

RUN echo 'Hello World'

ENTRYPOINT ["sleep 10"]
