FROM httpd:2.4
MAINTAINER wtakase <wataru.takase@kek.jp>

RUN apt-get -y update && apt-get install -y openssl curl

ADD run.sh run.sh
RUN chmod 755 run.sh

ADD elasticsearch.conf conf/extra/elasticsearch.conf
ADD kibana.conf conf/extra/kibana.conf

RUN sed -i -e "s/^#Include conf\/extra\/httpd-ssl.conf$/Include conf\/extra\/httpd-ssl.conf/" \
           -e "s/^#LoadModule ssl_module modules\/mod_ssl.so/LoadModule ssl_module modules\/mod_ssl.so/" \
           -e "s/^#LoadModule socache_shmcb_module modules\/mod_socache_shmcb.so/LoadModule socache_shmcb_module modules\/mod_socache_shmcb.so/" \
           -e "s/^#LoadModule rewrite_module modules\/mod_rewrite.so/LoadModule rewrite_module modules\/mod_rewrite.so/" \
           -e "s/^#LoadModule proxy_module modules\/mod_proxy.so/LoadModule proxy_module modules\/mod_proxy.so/" \
           -e "s/^#LoadModule proxy_http_module modules\/mod_proxy_http.so/LoadModule proxy_http_module modules\/mod_proxy_http.so/" \
           conf/httpd.conf
RUN sed -i -e "s/^ErrorLog.*/ErrorLog \/proc\/self\/fd\/1/" \
           -e "s/^CustomLog.*/CustomLog \/proc\/self\/fd\/1 \\\/" \
           -e "/^<\/VirtualHost>/i Include conf/extra/elasticsearch.conf" \
           -e "/^<\/VirtualHost>/i Include conf/extra/kibana.conf" \
           conf/extra/httpd-ssl.conf

COPY json /tmp/

EXPOSE 443
CMD ["./run.sh"]
