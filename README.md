## LogStash Dockerfile


This repository contains a **Dockerfile** of [Kibana](https://www.elastic.co/products/kibana/) for [Docker](https://www.docker.com/).


### Base Docker Image

* [dockerfile/java:oracle-java8](https://registry.hub.docker.com/u/dockerfile/java/)


### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/sxoded/logstash) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull sxoded/kibana4`
 
alternatively, you can build an image from Dockerfile:
 `docker build -t="sxoded/kibana4" github.com/sxoded/kibana4`)

### Usage

```sh
docker run -d --link <your_es_container_name>:es -p 9292:9292 sxoded/kibana4
```

 * the default config file uses port 9292 for the web interface
 * the web interface is served by nginx using a reverse proxy
 
#### Replace default configuration file

  1. Create a mountable configuration directory `<config-dir>` on the host.

  2. Create config file at `<config-dir>/kibana.yml` (this following is the default):

```yml
port: 5601

host: "localhost"

elasticsearch_url: "http://ES_HOST:9200"

elasticsearch_preserve_host: true

kibana_index: ".kibana"

default_app_id: "discover"

request_timeout: 300000

shard_timeout: 0

verify_ssl: false

bundled_plugin_ids:
 - plugins/dashboard/index
 - plugins/discover/index
 - plugins/doc/index
 - plugins/kibana/index
 - plugins/markdown_vis/index
 - plugins/metric_vis/index
 - plugins/settings/index
 - plugins/table_vis/index
 - plugins/vis_types/index
 - plugins/visualize/index
```

4. Start a container by mounting data directory and specifying the custom configuration file:

```sh
docker run -d --link <your_es_container_name>:es -p 9292:9292 sxoded/kibana4 -v <config-dir> sxoded/kibana4
```


