FROM nginx:alpine

ENV CONSUL_TEMPLATE_VERSION 0.16.0

ENV NGINX_CONFIG_PATH /etc/nginx/conf.d/

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /tmp/consul-template.zip

RUN unzip /tmp/consul-template.zip -d /usr/bin && \
    chmod +x /usr/bin/consul-template && \
    rm /tmp/consul-template.zip

ADD ./domains.conf /tmp/domains.conf

CMD /usr/sbin/nginx -c /etc/nginx/nginx.conf \
  &  consul-template \
  -consul="consul-server:8500" \
  -template "/tmp/domains.conf:$NGINX_CONFIG_PATH/domains.conf:/usr/sbin/nginx -s reload"
