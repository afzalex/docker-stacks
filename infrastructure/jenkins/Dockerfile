FROM jenkins/jenkins:lts 

EXPOSE 8080/tcp
EXPOSE 5000/tcp
USER root
RUN apt-get update 

# install necessary packages to run docker
RUN apt-get install docker.io -y
RUN apt-get install sudo -y

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
 
USER jenkins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt