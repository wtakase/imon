FROM elasticsearch:1.7
MAINTAINER wtakase <wataru.takase@kek.jp>

RUN /usr/share/elasticsearch/bin/plugin --install mobz/elasticsearch-head
RUN mkdir /usr/share/elasticsearch/config/templates
COPY templates /usr/share/elasticsearch/config/templates
