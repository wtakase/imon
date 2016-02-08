#docker rm -f `docker ps -aq`

docker run -d --name elasticsearch wtakase/elasticsearch-imon:1.7
sleep 5
docker run -d --name flume -p 9000:9000 -p 10000:10000 --link elasticsearch:elasticsearch wtakase/flume-imon:1.6
sleep 5
docker run -d --name irods01 --hostname irods01 -p 1247:1247 --link flume:flume wtakase/icat-imon:4.0.3 changeme
sleep 5
docker run -d --name kibana -e ELASTICSEARCH_URL=https://${DOCKER_SERVER:=192.168.99.100}/es wtakase/kibana-imon:4.1
sleep 5
docker run -d --name httpd -p 443:443 -e DOCKER_HOST=${DOCKER_SERVER=:192.168.99.100} --link elasticsearch:elasticsearch --link kibana:kibana wtakase/httpd-imon:2.4
sleep 5
docker run -d --name istats --link flume:flume --link irods01:irods -e IRODS_PASSWORD=changeme -e DEMO=1 wtakase/istats
docker ps
