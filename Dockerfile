ARG ALPINE_VERSION=3.11

FROM alpine:${ALPINE_VERSION} AS download
RUN apk add --update -q --progress --no-cache ca-certificates tzdata
ARG HASURA_CLI_VERSION=v1.1.0
WORKDIR /hasura
RUN touch config.yaml
RUN wget -q https://github.com/hasura/graphql-engine/releases/download/${HASURA_CLI_VERSION}/cli-hasura-linux-amd64 -O hasura && \
    chmod 500 hasura

FROM scratch
EXPOSE 9695/tcp 9693/tcp
ENTRYPOINT [ "/hasura" ]
CMD [ "console", "--no-browser", "--address", "0.0.0.0", "--endpoint", "http://host.docker.internal:80" ]
VOLUME [ "/.hasura" ]
COPY --from=download /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=download /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=download /hasura/config.yaml /config.yaml
COPY --from=download /hasura/hasura /hasura
