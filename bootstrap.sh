perl -p -i -e 's/ES_HOST/'"$ES_PORT_9200_TCP_ADDR"'/g' /opt/kibana/config/kibana.yml
service nginx start
/opt/kibana/bin/kibana
