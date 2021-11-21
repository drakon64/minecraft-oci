FROM oraclelinux:8-slim AS base

RUN useradd -r phantom

RUN mkdir /phantom
RUN chown phantom:phantom /phantom

WORKDIR /phantom
USER phantom

FROM base AS build-arm64
ARG ARM8
RUN curl -L "$ARM8" -o /phantom/phantom-linux

FROM base AS build-amd64
ARG AMD64
RUN curl -L "$AMD64" -o /phantom/phantom-linux

FROM build-${TARGETARCH} AS final
RUN chmod +x /phantom/phantom-linux
ENTRYPOINT [ "/phantom/phantom-linux", "-server" ]
