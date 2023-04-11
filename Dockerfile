FROM alpine:3.17.3

RUN apk update && apk add --no-cache curl bash

CMD ["bash"]