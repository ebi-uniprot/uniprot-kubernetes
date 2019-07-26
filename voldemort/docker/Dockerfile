FROM ubuntu:18.04

ARG VOLDEMORT_DIST=release-1.10.26-cutoff
ARG VOLDEMORT_DIST_DIR=voldemort-$VOLDEMORT_DIST

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    VOLDEMORT_USER=voldemort

# update the system, install wget and JDK, download Voldemort and build it, uninstall jdk and install JRE
RUN set -x \
    && apt-get update \
    && apt-get install -y wget openjdk-8-jdk \
    && wget -q "https://github.com/voldemort/voldemort/archive/$VOLDEMORT_DIST.tar.gz" \
    && tar -xzf "$VOLDEMORT_DIST.tar.gz" -C /opt \
    && rm -r "$VOLDEMORT_DIST.tar.gz" \
    && ln -s /opt/$VOLDEMORT_DIST_DIR /opt/voldemort \
    && cd /opt/voldemort \
    && ./gradlew clean build -x test \
    && apt-get autoremove -y wget openjdk-8-jdk \
    && apt-get install -y openjdk-8-jre-headless \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /opt/voldemort/.gradle \
    && rm -rf /opt/voldemort/.settings \
    && rm -rf /opt/voldemort/test \
    && rm -rf /opt/voldemort/example \
    && rm -rf /opt/voldemort/src \
    && rm -rf /opt/voldemort/dist/testclasses \
    && rm -rf /opt/voldemort/dist/classes

# Copy configuration generator script to bin
COPY scripts /opt/voldemort/bin/

# Create a user for the voldemort process and configure file system ownership
# for nessecary directories and symlink the distribution as a user executable
# Note: changing the ownership of the files will increase the image size
RUN set -x \
	&& useradd $VOLDEMORT_USER \
    && [ `id -u $VOLDEMORT_USER` -eq 1000 ] \
    && [ `id -g $VOLDEMORT_USER` -eq 1000 ] \
    && mkdir -p /tmp/voldemort /home/voldemort \
    && chown -R "$VOLDEMORT_USER:$VOLDEMORT_USER" /opt/$VOLDEMORT_DIST_DIR/bin /tmp/voldemort /home/voldemort \
    && ln -s /opt/voldemort/bin/* /usr/bin