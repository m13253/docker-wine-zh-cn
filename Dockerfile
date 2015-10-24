FROM suchja/wine:dev
MAINTAINER Star Brilliant <m13253@hotmail.com>

USER root

ADD https://github.com/adobe-fonts/source-han-sans/raw/release/OTF/SimplifiedChinese/SourceHanSansSC-Regular.otf /usr/share/fonts/TTF/SourceHanSansSC-Regular.otf
ADD https://github.com/adobe-fonts/source-han-sans/raw/release/OTF/SimplifiedChinese/SourceHanSansSC-Bold.otf /usr/share/fonts/TTF/SourceHanSansSC-Bold.otf
#ADD SourceHanSansSC-Regular.otf /usr/share/fonts/TTF/SourceHanSansSC-Regular.otf
#ADD SourceHanSansSC-Bold.otf /usr/share/fonts/TTF/SourceHanSansSC-Bold.otf

ADD sources.list /etc/apt/sources.list.new

RUN rm -rf /etc/apt/sources.list.d/* \
  && mv /etc/apt/sources.list /etc/apt/sources.list.old \
  && mv /etc/apt/sources.list.new /etc/apt/sources.list \
  && apt-get update -y \
  && apt-get install -y language-pack-en language-pack-zh-hans \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && mv /etc/apt/sources.list.old /etc/apt/sources.list

USER xclient
ENV DISPLAY 127.0.0.1:0
ENV LANG zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8
ENV LC_CTYPE C
ENV TZ Asia/Shanghai
ENV HOME /home/xclient
ENV WINEPREFIX /home/xclient/.wine
ENV WINEARCH win32
WORKDIR /home/xclient

ADD entrypoint.sh /entrypoint.sh
