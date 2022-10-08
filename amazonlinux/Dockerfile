FROM amazonlinux:2022

RUN yum update
RUN yum install sudo openssh-server openssh-clients -y
RUN yum install docker -y
RUN yum install ncurses tar git wget -y

RUN useradd -G root -m ciuser
RUN echo 'ciuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN ssh-keygen -A

USER ciuser
WORKDIR /home/ciuser

RUN ssh-keygen -N '' -f ~/.ssh/id_rsa <<< y
#ENTRYPOINT ["/usr/bin/tail"]
#CMD ["-f","/dev/null"]

CMD ["sudo", "/usr/sbin/sshd", "-De"]

