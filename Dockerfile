FROM java:7-jre
MAINTAINER 2degrees <2degrees-floss@googlegroups.com>

ENV \
    SOLR_VERSION=4.10.2 \
    SOLR_SHA1_CHECKSUM=b913204d07212d7bb814afe4641992f22404a27d \
    SOLR_USER=solr \
    SOLR_HOME_PATH=/etc/opt/solr \
    JETTY_HOME_PATH=/etc/opt/jetty \
    SOLR_DISTRIBUTION_PATH=/opt/solr \
    SOLR_INDICES_DIR_PATH=/var/opt/solr/indices

ARG mirror_url="http://archive.apache.org/dist/lucene/solr/${SOLR_VERSION}"

ADD build.sh /tmp/
RUN /tmp/build.sh "${mirror_url}"

ADD solr /usr/local/bin/
ADD log4j.properties "${JETTY_HOME_PATH}/resources/"

USER ${SOLR_USER}
EXPOSE 8983
CMD ["solr"]
