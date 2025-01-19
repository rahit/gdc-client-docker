FROM mambaorg/micromamba:latest
LABEL "Description"="The gdc-client provides several convenience functions for uploading/downloading via HTTPS at the gdc data portal"

COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yaml /tmp/environment.yaml
RUN micromamba install --yes --file /tmp/environment.yaml && \
    micromamba clean --all --yes
ARG MAMBA_DOCKERFILE_ACTIVATE=1  # (otherwise python will not be found)
RUN python -c 'import uuid; print(uuid.uuid4())' > /tmp/my_uuid

USER root
RUN apt-get update -y && apt-get install -y \
    build-essential \
    unzip \
    curl \
    wget \
    zlib1g-dev \
    ca-certificates
# Ensure CA certificates are updated
RUN update-ca-certificates

# Create symlink for CA certificates
RUN mkdir -p /etc/pki/tls/certs && \
    ln -s /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt

# clone git repository
RUN cd /tmp && wget https://gdc.cancer.gov/system/files/public/file/gdc-client_2.3_Ubuntu_x64-py3.8-ubuntu-20.04.zip && \
    unzip gdc-client_2.3_Ubuntu_x64-py3.8-ubuntu-20.04.zip && \
    unzip gdc-client_2.3_Ubuntu_x64.zip && \
    mv gdc-client /usr/bin/ && \
    rm -rf /tmp/gdc-client*


# Set working directory
WORKDIR /workspace

# Default command
CMD ["gdc-client", "--help"]

USER mambauser