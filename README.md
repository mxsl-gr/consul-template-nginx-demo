# consul-template-nginx-demo
dynamic domain demo by consul-template

## run

```
docker-compose up --build
````

1. Consul web ui: localhost:8500

2. [set dynamic domain](#set-domain)

3. [set hosts](#set-hosts) ([or use dns](#set-dns))

4. web: test.api-box.com

## set domain

key: mxsl/config/domain/test

value:

```json
{
  "domain":"test.api-box.com",
  "address":"test-server1",
  "port":3000
}
```

key: mxsl/config/domain/user

value:

```json
{
  "domain":"user.api-box.com",
  "address":"test-server2",
  "port":3000
}
```

## set hosts

edit: /etc/hosts:

```
127.0.0.1 user.api-box.com
127.0.0.1 test.api-box.com
```

## set dns

使用 DNS 服务商 API, 动态修改二级域名, 或者泛域名解析.

## other

动态域名配置在Consul的K/V配置, mxsl/config/domain/{domainName}路径下

内容为json, 例如为:

mxsl/config/domain/test

```json
{
  "domain":"test.api-box.com",
  "address":"test-server2",
  "port":3000
}
```

会生成nginx配置文件如下:

```
upstream test {
    server test-server2:3000;
}

server {
    listen 80;
    server_name test.api-box.com;
    location / {
        proxy_pass http://test;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        Host $http_host;
    }
}
```


