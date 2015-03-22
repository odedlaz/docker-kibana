FROM dockerfile/java:oracle-java8
MAINTAINER Oded Lazar oded@senexx.com

ENV DEBIAN_FRONTEND noninteractive
ENV KIBANA_PKG_NAME kibana-4.0.1-linux-x64

# nginx installation

RUN 	\
	apt-get update && \
	apt-get install -y nginx apache2-utils && \
	rm -rf /etc/nginx/sites-available/default

ADD config/nginx.conf /etc/nginx/sites-available/default

# kibana installation


RUN 	\
	cd /tmp && \
	wget https://download.elasticsearch.org/kibana/kibana/$KIBANA_PKG_NAME.tar.gz && \
	tar zxvf $KIBANA_PKG_NAME.tar.gz && \
	rm -rf $KIBANA_PKG_NAME.tar.gz && \
	mv $KIBANA_PKG_NAME /opt/kibana && \
	rm -rf /opt/kibana/config/kibana.yml

WORKDIR /opt/kibana

ADD config/kibana.yml config/kibana.yml

#RUN perl -p -i -e 's/(?<=elasticsearch_url: ").*(?=")/'"$ES_PORT_9200_TCP_ADDR"'/g' /config/kibana.yml
ADD bootstrap.sh ./
RUN chmod u+x bootstrap.sh

VOLUME ["/opt/kibana/config"]

ENTRYPOINT bash bootstrap.sh

EXPOSE 9292
