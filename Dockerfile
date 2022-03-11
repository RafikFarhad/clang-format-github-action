FROM silkeh/clang:12

LABEL maintainer="RafikFarhad<rafikfarhad@gmail.com>"

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
