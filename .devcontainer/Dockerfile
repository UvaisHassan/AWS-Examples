FROM ubuntu:22.04

RUN apt-get update && apt-get install -y git && apt-get clean

# Set up a non-root user
RUN useradd -ms /bin/bash devuser
USER devuser

# Default command to keep container running
CMD [ "bash" ]