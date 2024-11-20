FROM ubuntu:22.04

RUN apt-get update && apt-get install -y git && apt-get clean

# Set up a non-root user
RUN useradd -ms /bin/bash devuser
USER devuser
WORKDIR /workspace

# Copy the repo contents into the container and change ownership to devuser
COPY --chown=devuser:devuser . /workspace

# Default command to keep container running
CMD [ "bash" ]