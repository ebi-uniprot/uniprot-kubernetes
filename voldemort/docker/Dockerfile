FROM ubuntu:16.04

ENV VOLDEMORT_USER=voldemort \
JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

ARG VOLDEMORT_DIST=release-1.10.26-cutoff
ARG VOLDEMORT_DIST_DIR=voldemort-$VOLDEMORT_DIST

RUN set -x \
    && apt-get update \
    && apt-get install -y unzip openjdk-8-jdk wget

RUN set -x \
	&& wget -q "https://github.com/voldemort/voldemort/archive/$VOLDEMORT_DIST.tar.gz" \
	&& ls -l \
    && tar -xzf "$VOLDEMORT_DIST.tar.gz" -C /opt \
    && ls -l /opt \
    && ls -l /opt/$VOLDEMORT_DIST_DIR \
    && ln -s /opt/$VOLDEMORT_DIST_DIR /opt/voldemort \
    && ls -l /opt/voldemort/* \
    && rm -r "$VOLDEMORT_DIST.tar.gz"

# Download and install Gradle
RUN set -x \
    cd /usr/local \
    && wget -q https://services.gradle.org/distributions/gradle-2.5-bin.zip \
    && unzip gradle-2.5-bin.zip \
    && rm gradle-2.5-bin.zip

# Export some environment variables
ENV GRADLE_HOME=/usr/local/gradle-2.5
ENV PATH=$PATH:$GRADLE_HOME/bin
RUN set -x \
    && cd /opt/voldemort \
    && ./gradlew clean build -x test \
    && rm -rf $GRADLE_HOME

RUN set -x \
    && apt-get autoremove -y wget \
    && rm -rf /var/lib/apt/lists/*


#Copy configuration generator script to bin
COPY scripts /opt/voldemort/bin/

# Create a user for the voldemort process and configure file system ownership
# for nessecary directories and symlink the distribution as a user executable
RUN set -x \
	&& useradd $VOLDEMORT_USER \
    && [ `id -u $VOLDEMORT_USER` -eq 1000 ] \
    && [ `id -g $VOLDEMORT_USER` -eq 1000 ] \
    && mkdir -p /tmp/voldemort /usr/etc/ /home/voldemort \
	&& chown -R "$VOLDEMORT_USER:$VOLDEMORT_USER" /opt/$VOLDEMORT_DIST_DIR /opt/voldemort /tmp/voldemort /home/voldemort \
	&& ln -s /opt/voldemort/conf/ /usr/etc/voldemort \
	&& ln -s /opt/voldemort/bin/* /usr/bin

EXPOSE 2186 2187 2185
