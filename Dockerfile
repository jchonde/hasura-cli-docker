FROM alpine

WORKDIR /workspace

RUN apk add --no-cache curl bash

RUN curl -L https://github.com/hasura/graphql-engine/raw/master/cli/get.sh | bash

COPY . .

CMD hasura
