FROM debian:bookworm-slim

# Set up archived apt sources and install dependencies
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y zip unzip curl bash && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

ARG USER_UID="1000"
ARG USER_NAME="jenkins"

RUN useradd -m -U -u $USER_UID $USER_NAME

USER $USER_UID
ENV SDKMAN_DIR="/home/jenkins/.sdkman"

# Install SDKMAN directly into the user's home and make sure it's sourced in the same RUN layer
RUN curl -s "https://get.sdkman.io" | bash && \
    bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh && \
             yes | sdk install java 11.0.21-tem && \
             yes | sdk install maven 3.9.6 && \
             sdk flush archives && \
             sdk flush temp"

# Make sure the environment variables are available globally
ENV JAVA_HOME="/home/jenkins/.sdkman/candidates/java/current"
ENV MAVEN_HOME="/home/jenkins/.sdkman/candidates/maven/current"
ENV PATH="$JAVA_HOME/bin:$MAVEN_HOME/bin:$PATH"

CMD ["bash"]
