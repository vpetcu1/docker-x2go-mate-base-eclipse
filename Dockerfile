FROM vpetcu1/x2go-mate-base
MAINTAINER Vasilica Petcu <vpetcu1@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

ARG GRAAL_VERSION=1.0.0-rc16
#ARG GRAAL_VERSION=19.0.0

USER root

# install wget
RUN apt-get update && apt-get install wget -y

# install openJDK
RUN apt-get install default-jdk -y

# install maven
RUN wget https://www-us.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz -P /tmp
RUN tar xf /tmp/apache-maven-*.tar.gz -C /opt
RUN ln -s /opt/apache-maven-3.6.0 /opt/maven


#install graalvm
RUN wget https://github.com/oracle/graal/releases/download/vm-$GRAAL_VERSION/graalvm-ce-$GRAAL_VERSION-linux-amd64.tar.gz -P /tmp
#RUN wget https://github.com/oracle/graal/releases/download/vm-$GRAAL_VERSION/graalvm-ce-linux-amd64-$GRAAL_VERSION.tar.gz -P /tmp
RUN tar xf /tmp/graalvm-ce-*.tar.gz -C /opt
RUN ln -s /opt/graalvm-ce-$GRAAL_VERSION /opt/graalvm


# install eclipse
RUN wget http://ftp.halifax.rwth-aachen.de/eclipse//technology/epp/downloads/release/2019-03/R/eclipse-jee-2019-03-R-linux-gtk-x86_64.tar.gz -P /tmp
RUN tar xf /tmp/eclipse-jee-*.tar.gz -C /opt

#install git
RUN apt-get update
RUN apt-get install git -y

#install docker
RUN apt-get update
RUN apt-get -y install apt-transport-https ca-certificates curl software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo \"$UBUNTU_CODENAME\") stable"
RUN apt-get update
RUN apt-get -y install docker-ce docker-compose

#clean up
RUN rm -rf /tmp/*
RUN apt-get autoclean && apt autoremove -y
RUN rm -rf /var/lib/apt/lists/*


ENV REMOTE_USER=desktop
ENV PROJECT_NAME=Test
ENV REMOTE_PASSWORD=password

COPY ["*.sh", "/"]
COPY ["eclipse_preferences.epf", "/"]

RUN cp /set_env.sh /etc/profile.d/set_env.sh
RUN chmod +x /*.sh

RUN sh /x2go-mate-base-eclipse-entrypoint.sh
EXPOSE 22
ENTRYPOINT ["/start-supervisor.sh"]
