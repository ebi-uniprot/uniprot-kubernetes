FROM ubuntu:18.04

ENV RESTFUL_USER=restful \
    RESTFUL_DIR=/restful \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

RUN set -x \
    && apt-get update \
    && apt-get install -y openjdk-8-jre-headless

#Copy configuration generator script to bin
COPY scripts $RESTFUL_DIR/bin/

# Copy jar from local lib to lib
# make sure the jar in the local lib being updated
COPY lib /opt/restful/lib

# Create a user for the restful process and configure file system ownership
# for nessecary directories and symlink the distribution as a user executable
# Note: changing the ownership of the files will increase the image size
RUN set -x \
	&& useradd $RESTFUL_USER \
    && [ `id -u $RESTFUL_USER` -eq 1000 ] \
    && [ `id -g $RESTFUL_USER` -eq 1000 ] \
	&& chown -R "$RESTFUL_USER:$RESTFUL_USER" $RESTFUL_DIR \
	&& mkdir -p $RESTFUL_DIR/lib \
	&& ln -s /opt/restful/lib/support-data-rest-*.jar  $RESTFUL_DIR/lib/support-data-rest-exec.jar \
	&& ln -s $RESTFUL_DIR/bin/* /usr/bin
