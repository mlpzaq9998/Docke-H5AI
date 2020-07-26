#!/bin/sh
echo ""
echo "Starting Docker-Linux ... "
echo ""
echo "[$(date "+%G/%m/%d %H:%M:%S")] Deploying h5ai ..."
echo "[$(date "+%G/%m/%d %H:%M:%S")] Unpacking h5ai ..."
cp /var/h5ai/h5ai.zip /h5ai/h5ai.zip
cd /h5ai/
unzip -qo h5ai.zip
echo "[$(date "+%G/%m/%d %H:%M:%S")] Changing owner for /h5ai/ ..."
chown -R apache:apache /h5ai/
echo "[$(date "+%G/%m/%d %H:%M:%S")] Changing privilege for /h5ai/_h5ai/private/cache/ ..."
# chmod -R 777 /h5ai/_h5ai/private/cache/
echo "[$(date "+%G/%m/%d %H:%M:%S")] Changing privilege for /h5ai/_h5ai/public/cache/ ..."
# chmod -R 777 /h5ai/_h5ai/public/cache/
echo "[$(date "+%G/%m/%d %H:%M:%S")] Applying Apache 2 Settings ..."
echo "DirectoryIndex /_h5ai/public/index.php" >> /h5ai/.htaccess 
echo "[$(date "+%G/%m/%d %H:%M:%S")] Cleaning up ..."
rm -f /h5ai/h5ai.zip
echo "[$(date "+%G/%m/%d %H:%M:%S")] Finishing Deployment ..."
echo ""
echo " --- Information of the running enviroment --- "
echo ""
echo " Linux Version : Alpine Linux $(cat /etc/alpine-release)"
echo " Linux Kernel Version : $(uname -r)"
echo " Linux Architecture : $(uname -m)"
echo " Docker Hostname : $(uname -n)"
echo " Server IP : $(curl -s whatismyip.akamai.com)"
echo ""
#echo " Linux ROOT User Password : $ROOT_PASSWORD "
echo ""
echo "***********************************************"
echo ""
echo "[$(date "+%G/%m/%d %H:%M:%S")] Starting Apache ... "
echo "[$(date "+%G/%m/%d %H:%M:%S")] Start Success ! Enjoy your Docker-h5ai ! "
echo ""
echo "***********************************************"
echo ""
echo "***********************************************"
echo ""
httpd -D FOREGROUND