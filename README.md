iMon (iRODS Monitoring framework)
====

iRODS monitor framework running based on EFK (ElasticSearch, Flume, and Kibana).

Overview
----

![iMon overview](https://github.com/wtakase/imon/raw/master/images/imon_overview.png "iMon Overview")

* Flume agent on each iRODS server sends rodsLog to port 10000 on Flume container.

* istats collects statistical information from each iRODS server by using python-irodsclient and sends it to port 9000 on Flume container every 10 minutes.

* You can check these information on Kibana dashboards:

    * rodsLog dashboard on the Discovery tab.

    * Statistical usage dashbard on the Dashboard tab:

        * Number of Objects: per resource, per user

        * Object size: per resource, per user

        * Number of Accesses: per user, per access-from

        * Number of Errors: per error status

        * Number of Users

![iMon rodslog](https://github.com/wtakase/imon/raw/master/images/imon_rodslog.png "iMon rodslog")

![iMon rodsstats](https://github.com/wtakase/imon/raw/master/images/imon_rodsstats.png "iMon rodsstats")

Demo
----

* Execute following commands on your Docker host and you will have iMon environment:

```bash
export DOCKER_SERVER="xxx.xxx.xxx.xxx"
./demo.sh
```

* Above shell script boots all necessary services including iRODS as Docker containers.

* And then iRODS users and objects are created automatically every miniute for the demo.

* You can browse Kibana monitoring page on https://DOCKER_SERVER .

    * Go to Discover page and open `rodslog` search.

    * Go to Dashboard page and open `tempZone` dashboard.

Monitoring against existing iRODS
----

* Boot containers on your Docker host:

```bash
export DOCKER_SERVER="xxx.xxx.xxx.xxx"
docker run -d --name elasticsearch -v "$PWD"/es_data:/usr/share/elasticsearch/data wtakase/elasticsearch-imon:1.7
docker run -d --name flume -p 9000:9000 -p 10000:10000 --link elasticsearch:elasticsearch wtakase/flume-imon:1.6
docker run -d --name kibana -e ELASTICSEARCH_URL=https://${DOCKER_SERVER}/es wtakase/kibana-imon:4.1
docker run -d --name httpd -p 443:443 -e DOCKER_HOST=${DOCKER_SERVER} --link elasticsearch:elasticsearch --link kibana:kibana wtakase/httpd-imon:2.4
```

* Set cron job for iRODS log rotation

```bash
echo "*/10 * * * * root /path/to/imon/docker/icat/rotate_rodslog.sh" >> /etc/crontab
```

* Install Flume (flume-ng and flume-ng-agent) to your iRODS server.

* Put /path/to/imon/docker/icat/flume.conf to /path/to/flume/conf on your iRODS server and replace FLUME_HOST with your Docker hostname.

    * Any requests to port 10000 on your Docker host will be redirected to Flume container's port.

* Start Flume service with the flume.conf.

* Boot istats container with your iRODS server IP (replace xxx.xxx.xxx.xxx below) and password (replace xxxxx below):

```bash
docker run -d --name istats --link flume:flume -e IRODS_PORT_1247_TCP_ADDR=xxx.xxx.xxx.xxx -e IRODS_PASSWORD=xxxxx wtakase/istats
```

* You can browse Kibana monitoring page on https://DOCKER_SERVER .

Dockerfile
----

* All Docker images are built by using docker/xxx/Dockerfile.
