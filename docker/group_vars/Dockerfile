FROM oraclelinux:8-slim

RUN microdnf -y install jq java-17-openjdk-headless

RUN useradd minecraft
USER minecraft
WORKDIR /opt/minecraft

COPY paper_latest.sh paper_latest.sh
ARG version
RUN sh -ex paper_latest.sh $version

RUN mkdir plugins
WORKDIR /opt/minecraft/plugins

COPY chunky_latest.sh chunky_latest.sh
RUN sh -ex chunky_latest.sh

RUN curl https://ci.opencollab.dev/job/GeyserMC/job/Geyser/job/master/lastSuccessfulBuild/artifact/bootstrap/spigot/target/Geyser-Spigot.jar -o Geyser-Spigot.jar

RUN curl https://ci.opencollab.dev/job/GeyserMC/job/Floodgate/job/master/lastSuccessfulBuild/artifact/spigot/target/floodgate-spigot.jar -o floodgate-spigot.jar

COPY tabtps_latest.sh tabtps_latest.sh
RUN sh -ex tabtps_latest.sh

COPY viaversion_latest.sh viaversion_latest.sh
RUN sh -ex viaversion_latest.sh

WORKDIR /opt/minecraft
RUN echo "eula=true" > eula.txt

ENTRYPOINT [ "/usr/bin/java", "-Xmx1024M", "-Xms1024M", "-jar", "server.jar" ]
