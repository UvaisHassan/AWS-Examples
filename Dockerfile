FROM ubuntu:22.04

RUN apt-get update && apt-get install -y git && apt-get clean

# Set up a non-root user
RUN useradd -ms /bin/bash devuser
USER devuser
WORKDIR /workspace

# Clone the repo
RUN git clone https://github.com/UvaisHassan/AWS-Examples.git

# Default command to keep container running
CMD [ "bash" ]