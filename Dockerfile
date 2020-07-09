FROM unibeautify/clang-format:latest

LABEL maintainer="RafikFarhad<rafikfarhad@gmail.com>"

RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]