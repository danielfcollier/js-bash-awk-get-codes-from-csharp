FROM bash:latest
WORKDIR /app

RUN apk add --update gawk icu-data-full make nodejs

COPY . .

RUN make local
