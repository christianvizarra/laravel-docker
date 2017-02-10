FROM amazonlinux
MAINTAINER Christian Vizarra <christian.vizarra@flightdigitalmedia.com>

RUN yum update -y

RUN yum  -y install -y httpd24 php70 mysql56-server git zip --skip-broken
RUN yum -y install php70-gd php70-imap php70-mbstring php70-mysqlnd php70-opcache php70-pdo php70-pecl-apcu php70-zip php70-pecl-memcache php70-pecl-memcached

EXPOSE 80
EXPOSE 443

CMD ["/bin/bash"]
