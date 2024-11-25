FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    sudo \
    tree \
    jq \
    && apt-get clean

# Download and install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install \
    && rm -rf awscliv2.zip aws

# Set up a non-root user
RUN useradd -ms /bin/bash devuser
USER devuser

# Default command to keep container running
CMD [ "bash" ]