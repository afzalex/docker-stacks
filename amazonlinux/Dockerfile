FROM amazonlinux:2022

RUN yum update
RUN yum install docker -y
RUN yum install openssh-server openssh-clients -y
RUN yum install ncurses git -y

RUN ssh-keygen -N '' -f ~/.ssh/id_rsa <<< y
RUN mkdir /var/run/sshd
RUN echo root:mypassword | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN ssh-keygen -A

#ENTRYPOINT ["/usr/bin/tail"]
#CMD ["-f","/dev/null"]

CMD ["/usr/sbin/sshd", "-D"]

