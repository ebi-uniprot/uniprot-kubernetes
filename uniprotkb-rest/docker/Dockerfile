FROM ubuntu:16.04

ENV RESTFUL_USER=restful \
RESTFUL_DIR=/restful \
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

RUN set -x \
    && apt-get update \
    && apt-get install -y openjdk-8-jre

#Copy configuration generator script to bin
COPY scripts $RESTFUL_DIR/bin/
COPY lib $RESTFUL_DIR/lib

# Create a user for the restful process and configure file system ownership
# for nessecary directories and symlink the distribution as a user executable
RUN set -x \
	&& useradd $RESTFUL_USER \
    && [ `id -u $RESTFUL_USER` -eq 1000 ] \
    && [ `id -g $RESTFUL_USER` -eq 1000 ] \
	&& chown -R "$RESTFUL_USER:$RESTFUL_USER" $RESTFUL_DIR \
	&& ln -s $RESTFUL_DIR/lib/uniprotkb-rest-*.jar  $RESTFUL_DIR/lib/uniprotkb-rest-exec.jar \
	&& ln -s $RESTFUL_DIR/bin/* /usr/bin

EXPOSE 8090
