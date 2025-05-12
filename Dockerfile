FROM confluentinc/cp-kafka:7.4.0

USER root

RUN microdnf install -y jq && \
    microdnf clean all && \
    rm -rf /var/cache/dnf
