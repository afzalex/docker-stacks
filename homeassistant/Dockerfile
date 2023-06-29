FROM debian:stable-slim

RUN apt-get update && \
    apt-get install -y sudo wget curl iputils-ping vim jq git
RUN apt-get install -y "ffmpeg=7:4.3.4-0+deb11u1" 
# RUN apt-get install -y "unoconv=0.7-2"


RUN apt-get install -y "youtube-dl=2021.06.06-1" 
RUN apt-get install -y "libreoffice=1:7.0.4-4+deb11u3" 

RUN useradd -G root -m stuser && \
    echo 'stuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    mkdir -p /home/stuser/hostpwd && \
    touch /home/stuser/hostpwd/NA_FLAG_this_file_is_present_when_host_pwd_is_not_mounted
USER stuser
ENV PATH "$PATH:/home/stuser/.local/bin"

RUN wget -v https://repo.anaconda.com/miniconda/Miniconda3-py38_4.12.0-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    sudo mkdir -p /opt/conda && \
    sudo chown -R "stuser:stuser" /opt/conda && \
    bash /tmp/miniconda.sh -bup /opt/conda
    
RUN eval "$(/opt/conda/bin/conda shell.bash hook)" && \
    conda init 

COPY requirements.txt /home/stuser/requirements.txt

# SHELL ["/bin/bash", "-c"]
RUN eval "$(/opt/conda/bin/conda shell.bash hook)" && \
    pip install -r /home/stuser/requirements.txt

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

RUN echo 'PS1="\e[1;38m$PS1\e[0m"' >> /home/stuser/.bashrc

WORKDIR /home/stuser/hostpwd
ENTRYPOINT [ "/bin/bash" ]

