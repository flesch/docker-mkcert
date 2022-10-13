ARG GO_VERSION=1.19-alpine
FROM golang:$GO_VERSION AS build-env

ARG GIT_VERSION=2.36.2
RUN apk update && apk add --no-cache git~=$GIT_VERSION

WORKDIR /src

RUN git clone https://github.com/FiloSottile/mkcert /src
RUN CGO_ENABLED=0 go build -o /bin/mkcert -ldflags "-X main.Version=$(git describe --tags)"

FROM scratch AS runtime-env
WORKDIR /.local/share/mkcert
COPY --from=build-env /bin/mkcert /bin/mkcert
ENTRYPOINT ["/bin/mkcert"]
