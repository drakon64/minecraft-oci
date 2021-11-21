FROM oraclelinux:8-slim

RUN useradd phantom

RUN mkdir /phantom
RUN chown phantom:phantom /phantom
ADD --chown=phantom:phantom phantom_docker.sh /phantom/

RUN microdnf -y install jq

WORKDIR /phantom
USER phantom
RUN chmod 0755 phantom_docker.sh
RUN ./phantom_docker.sh
RUN rm phantom_docker.sh
USER root
RUN microdnf clean all
ENTRYPOINT [ "/phantom/phantom-linux", "-server" ]
