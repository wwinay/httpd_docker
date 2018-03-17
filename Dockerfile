FROM centos
MAINTAINER vinay.khandalkar
ENV container docker
RUN yum update -y;
#RUN yum -y install systemd; \
#(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
# rm -f /lib/systemd/system/multi-user.target.wants/*;\
# rm -f /etc/systemd/system/*.wants/*;\
# rm -f /lib/systemd/system/local-fs.target.wants/*; \
# rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
# rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
# rm -f /lib/systemd/system/basic.target.wants/*;\
# rm -f /lib/systemd/system/anaconda.target.wants/*;
# VOLUME [ “/sys/fs/cgroup” ]
# CMD [“/usr/sbin/init”]
RUN yum install curl wget httpd sudo -y;
RUN yum install -y git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel net-tools tcpdump;
#RUN wget https://toolbelt.treasuredata.com/sh/install-redhat-td-agent2.sh \
# && sh install-redhat-td-agent2.sh -y \
# && service td-agent start \
# && service td-agent status;
#RUN passwd root <<-EOF
#redhat
#redhat
#EOF

#RUN /opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-secure-forward;
#RUN /opt/td-agent/embedded/bin/gem install fluent-plugin-splunk-ex;
#RUN echo $'<source>\n\
#  @type forward\n\
  #self_hostname "#{ENV[\'HOSTNAME\']}" \n\
#  bind 0.0.0.0\n\
#  port 24284\n\
#
  #shared_key ocpaggregatedloggingsharedkey\n\

  #secure no\n\
  #enable_strict_verification no\n\
  #cert_path        /etc/td-agent/certs/ca_cert.pem\n\
  #private_key_path /etc/td-agent/certs/ca_key.pem\n\
  #private_key_passphrase ocpsecureforward\n\
#</source>\n\
#<match **>\n\
#   type splunk_ex\n\
#   host 10.50.211.54\n\
#   port 9997\n\
#   output_format json\n\
#</match>\n'\
#> /etc/td-agent/td-agent.conf

 #&& systemctl start td-agent \
 #&& systemctl status td-agent
RUN echo $'Hello this is Openshift httpd'\
> /var/www/html/index.html
RUN echo $'ServerName test.oso.com:8081'\
>> /etc/httpd/conf/httpd.conf
RUN sed -i 's/Listen 80/Listen 8081/g' /etc/httpd/conf/httpd.conf
#EXPOSE 24284
EXPOSE 8081
#RUN echo $'#httpd &\n\
#td-agent -c /etc/td-agent/td-agent.conf -o /var/log/td-agent/td-agent.log &'\
#> /tmp/script.sh
#RUN chmod 777 /tmp/script.sh
#RUN mkdir -p /etc/td-agent/certs
RUN mkdir -p /var/log/td-agent\
 && mkdir -p /run/httpd/\
 && chmod -R 777 /run/httpd;
RUN chmod -R 777 /etc/httpd\
 && chmod -R 777 /var/log/httpd\
 && chmod -R 777 /usr/lib64/httpd/modules;
#RUN touch /var/log/td-agent/td-agent.log
#RUN chmod -R 777 /var/log/td-agent/
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
#CMD ["/usr/sbin/td-agent", "-c", "/etc/td-agent/td-agent.conf", "-o", "/var/log/td-agent/td-agent.log"]
#ENTRYPOINT ["/bin/bash", "/tmp/script.sh"]
#RUN /bin/bash /tmp/script.sh
#CMD ["sh", "/tmp/script.sh"]
