FROM ubuntu:18.04

ARG RESTFUL_USER=restful
ARG RESTFUL_GROUP=restful
ARG RESTFUL_UID=2796
ARG RESTFUL_GID=1128
ARG RESTFUL_LIB_DIR=/opt/restful

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Update and install JRE
RUN set -x \
    && apt-get update \
    && apt-get install -y openjdk-8-jre-headless

# Copy configuration generator script to bin
COPY scripts $RESTFUL_LIB_DIR/bin/

# Copy jar from local lib to lib
# make sure the jar in the local lib being updated
COPY lib $RESTFUL_LIB_DIR/lib

# Copy some meta data over
COPY ff $RESTFUL_LIB_DIR/ff

# Create a user for the restful process and configure file system ownership
# for nessecary directories and symlink the distribution as a user executable
# Note: changing the ownership of the files will increase the image size
RUN set -x \
    && groupadd -r --gid "$RESTFUL_GID" "$RESTFUL_GROUP" \
    && useradd -r --uid "$RESTFUL_UID" --gid "$RESTFUL_GID" "$RESTFUL_USER" \
    && ln -s $RESTFUL_LIB_DIR/lib/uniprotkb-rest-*.jar  $RESTFUL_LIB_DIR/lib/uniprotkb-rest-exec.jar \
	&& chown -R "$RESTFUL_USER:$RESTFUL_GROUP" $RESTFUL_LIB_DIR \
	&& ln -s $RESTFUL_LIB_DIR/bin/* /usr/bin
