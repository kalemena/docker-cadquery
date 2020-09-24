FROM ubuntu:18.04

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Compiler tools
RUN    apt-get update -y \
    && apt-get install -qqy \
        wget \
        libgl1-mesa-glx \
        libxi6 \
    && apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb

RUN    cd /opt \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-py37_4.8.3-Linux-x86_64.sh -O miniconda.sh \
    && bash miniconda.sh -b -p /opt/miniconda
    
ENV PATH="/opt/miniconda/bin:/opt/miniconda/lib:$PATH"

RUN    conda config --set always_yes yes --set changeps1 no \
    && conda install -c cadquery -c conda-forge \
        cadquery=master \
        cq-editor=master \
    && conda clean -a -y
