FROM debian:bookworm-slim

# Install required tools
RUN apt-get update && \
    apt-get install -y zip unzip curl bash && \
    rm -rf /var/lib/apt/lists/*

# Create non-root user
ARG USER_UID=1000
ARG USER_NAME=jenkins
RUN useradd -m -U -u $USER_UID $USER_NAME

# Switch to non-root user
USER $USER_NAME
ENV SDKMAN_DIR="/home/$USER_NAME/.sdkman"

# Install SDKMAN and Java
RUN curl -s "https://get.sdkman.io" | bash && \
    bash -c "source $SDKMAN_DIR/bin/sdkman-init.sh && \
    yes | sdk install java 11.0.21-tem"

# Set Java environment variables
ENV JAVA_HOME="/home/$USER_NAME/.sdkman/candidates/java/current"
ENV PATH="$JAVA_HOME/bin:$PATH"

# Start with bash
CMD ["bash"]
