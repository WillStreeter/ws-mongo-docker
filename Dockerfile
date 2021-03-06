FROM alpine:3.5

MAINTAINER Will Streeter <will.streeter@gmail.com>

#Install mongodb

ARG DB_USER
ARG DB_PASSWORD
ARG DB_ROLE
ARG DB_STORAGE_ENGINE
ARG DB_JOURNALING
ARG DB_MOUNTPOINT
ARG MONGODB_VERSION
ARG MONGODB_PORT

ENV DB_USER ${DB_USER}
ENV DB_PASSWORD ${DB_PASSWORD}
ENV DB_ROLE ${DB_ROLE}
ENV DB_STORAGE_ENGINE ${DB_STORAGE_ENGINE}
ENV DB_JOURNALING ${DB_JOURNALING}
ENV DB_MOUNTPOINT ${DB_MOUNTPOINT}
ENV MONGODB_VERSION ${MONGODB_VERSION}
ENV MONGODB_PORT ${MONGODB_PORT}


ENV PATH ${PATH}:/opt/mongodb-linux-x86_64-${MONGODB_VERSION}/bin

EXPOSE $MONGODB_PORT

ADD mongodb-linux-x86_64-${MONGODB_VERSION}.tgz /opt

RUN mkdir -p $DB_MOUNTPOINT

CMD rm /mongodb/data/mongod.lock || true \
  && mongod \
  --dbpath $DB_MOUNTPOINT \
  --port $MONGODB_PORT \
  --storageEngine $DB_STORAGE_ENGINE \
  --$DB_JOURNALING