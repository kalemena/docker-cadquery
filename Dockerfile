FROM ubuntu:20.04

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
ARG ADDITIONAL_PACKAGES
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Cad Query" \
      org.label-schema.description="Kalemena Cad Query" \
      org.label-schema.url="private" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/kalemena/docker-cadquery" \
      org.label-schema.vendor="Kalemena" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Compiler tools
RUN    apt-get update -y \
    && apt-get install -qqy \
        wget bzip2 ca-certificates software-properties-common \
        libglu1-mesa libgl1-mesa-dri mesa-common-dev libglu1-mesa-dev \
        libxi6 fonts-freefont-ttf \
    && apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# qt5-default \

ENV QT_XKB_CONFIG_ROOT=/usr/share/X11/xkb
# ENV QT_DEBUG_PLUGINS=1
 
RUN    cd /opt \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-py37_4.9.2-Linux-x86_64.sh -O miniconda.sh \
    && bash miniconda.sh -b -p /opt/miniconda
    
ENV PATH="/opt/miniconda/bin:/opt/miniconda/lib:$PATH"

RUN    conda config --set always_yes yes --set changeps1 no \
    && conda install -c cadquery -c conda-forge \
        cadquery=master \
        cq-editor=master \
    && conda clean -a -y

ADD requirements.txt /opt/

RUN conda install --file /opt/requirements.txt -y; \
    conda clean -a -y;
CMD ["/opt/miniconda/bin/cq-editor"]
