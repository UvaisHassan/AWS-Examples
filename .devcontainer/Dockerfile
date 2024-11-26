FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
  git \
  curl \
  unzip \
  sudo \
  wget \
  gpg \
  lsb-release \
  tree \
  jq

# Download and install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && unzip awscliv2.zip \
  && ./aws/install \
  && rm -rf awscliv2.zip aws

# Download and install Terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list \
  && apt-get update && apt-get install -y terraform

# Setup Node.js and install AWS CDK
RUN curl -sL https://deb.nodesource.com/setup_20.x -o nodesource_setup.sh \
  && bash nodesource_setup.sh \
  && apt-get install -y nodejs \
  && npm install -g aws-cdk

# Install Pulumi and setup Python
RUN curl -fsSL https://get.pulumi.com | sh \
  && mv /root/.pulumi/bin/pulumi* /usr/local/bin/ \
  && apt-get install -y python3 python3-venv

# Remove downloaded package files that are no longer needed
RUN apt-get clean

# Set up a non-root user
RUN useradd -ms /bin/bash devuser
USER devuser

# Default command to keep container running
CMD [ "bash" ]