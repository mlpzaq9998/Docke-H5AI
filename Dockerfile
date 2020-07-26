#本镜像基于最新版alpine
FROM alpine:3.12.0

LABEL MAINTAINER="ZYL"

# PHP 设置
ENV INSTALL_PHP_EXTENSION="php7-cli php7-json php7-phar php7-iconv php7-openssl php7-zlib php7-session unzip "

# ===== 环境安装部分 =====
# 系统基础环境
RUN (sed -i "s/dl-cdn.alpinelinux.org/${APK_MIRROR}/g" /etc/apk/repositories ;\
     sed -i "s/http/${APK_MIRROR_SCHEME}/g" /etc/apk/repositories ;\
	 cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	 echo 'Asia/Shanghai' >  /etc/timezone \
     apk --no-cache upgrade ;\
     apk --no-cache add curl )

# 安装 Apache2
RUN (apk --no-cache add php7-apache2)

# 安装 PHP 及其扩展
RUN (apk --no-cache add  ${INSTALL_PHP_EXTENSION} ;\
     curl -sS https://getcomposer.org/installer | php ;\
     mv composer.phar /usr/local/bin/composer )

# Apache 2 配置
RUN (sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/httpd.conf ;\
     sed -i "/mod_rewrite.so/s/#LoadModule/LoadModule/" /etc/apache2/httpd.conf ;\
     sed -i "s/\/var\/www\/localhost\/htdocs/\/h5ai/" /etc/apache2/httpd.conf ;\
     mkdir /run/apache2/ ;\
     mkdir /h5ai/ )

# 垃圾清理
RUN (rm -rf /var/cache/apk/* /tmp/* ;\
     rm -f /var/www/localhost/htdocs/index.html )

# 添加脚本
ADD scripts/ /scripts/

# 添加网站程序
# ADD wwwroot/ /h5ai/
ADD h5ai/h5ai.zip /var/h5ai/h5ai.zip

# 配置权限
RUN (chmod -R 755 /scripts/ )

EXPOSE 80

VOLUME [ "/h5ai" ]

ENTRYPOINT [ "sh", "/scripts/entrypoint.sh" ]