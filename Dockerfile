ARG slim=N

FROM debian AS download
WORKDIR /
RUN apt-get update && apt-get install -y curl unzip && \
    curl -O https://udomain.dl.sourceforge.net/project/pentaho/Pentaho%209.1/client-tools/pdi-ce-9.1.0.0-324.zip && \
    unzip pdi-ce-9.1.0.0-324.zip
RUN cp -r  /data-integration /data-integration-slim && \
    rm -rf /data-integration-slim/classes/kettle-lifecycle-listeners.xml && \
    rm -rf /data-integration-slim/classes/kettle-registry-extensions.xml && \
    rm -rf /data-integration-slim/lib/mondrian-*.jar && \
    rm -rf /data-integration-slim/lib/org.apache.karaf.*.jar && \
    rm -rf /data-integration-slim/lib/pdi-engine-api-*.jar && \
    rm -rf /data-integration-slim/lib/pdi-engine-spark-*.jar && \
    rm -rf /data-integration-slim/lib/pdi-osgi-bridge-core-*.jar && \
    rm -rf /data-integration-slim/lib/pdi-spark-driver-*.jar && \
    rm -rf /data-integration-slim/lib/pentaho-connections-*.jar && \
    rm -rf /data-integration-slim/lib/pentaho-cwm-*.jar && \
    rm -rf /data-integration-slim/lib/pentaho-hadoop-shims-api-*.jar && \
    rm -rf /data-integration-slim/lib/pentaho-osgi-utils-api-*.jar && \
    rm -rf /data-integration-slim/plugins/kettle5-log4j-plugin && \
    rm -rf /data-integration-slim/plugins/pentaho-big-data-plugin && \
    rm -rf /data-integration-slim/system/karaf && \
    rm -rf /data-integration-slim/system/mondrian && \
    rm -rf /data-integration-slim/system/osgi

FROM openjdk:17 AS copy-slim-Y
WORKDIR /
COPY --from=download  /data-integration-slim  /

FROM openjdk:17 AS copy-slim-N
WORKDIR /
COPY --from=download  /data-integration  /

FROM copy-slim-${slim}