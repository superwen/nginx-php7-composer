
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
wget -O /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo

rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

yum clean all && yum makecache && yum -y update

yum install -y gcc gcc-c++ libjpeg libjpeg-devel libpng-devel freetype freetype-devel yum-utils 
yum install -y nginx
yum-config-manager --enable remi-php73
yum -y install php php-devel php-fpm php-pdo php-pdo_mysql php-pear phpmbstring php-mcrypt php-devel php-cli php-gd php-pear php-curl php-mysql php-ldap php-zip php-fileinfo 

sed -ie "s/;date.timezone =/date.timezone = Asia\/Chongqing/" /etc/php.ini
sed -ie "s/user = apache/user = nginx/" /etc/php-fpm.d/www.conf
sed -ie "s/group = apache/group = nginx/" /etc/php-fpm.d/www.conf

mv opcache.ini /etc/php.d/opcache.ini

mkdir -p /hwdata/www
mkdir -p /hwdata/log/nginx
chown nginx:nginx /hwdata/log/nginx

mv www/* /hwdata/www


systemctl enable nginx && systemctl enable php-fpm

systemctl start nginx && systemctl start php-fpm

yum install -y redis
systemctl enable redis && systemctl start redis

yum install -y supervisord
systemctl daemon-reload && systemctl enable supervisord && systemctl start supervisord 


wget http://mirrors.ustc.edu.cn/mysql-ftp/Downloads/MySQL-5.7/mysql-community-server-5.7.29-1.el7.x86_64.rpm
wget http://mirrors.ustc.edu.cn/mysql-ftp/Downloads/MySQL-5.7/mysql-community-libs-5.7.29-1.el7.x86_64.rpm
wget http://mirrors.ustc.edu.cn/mysql-ftp/Downloads/MySQL-5.7/mysql-community-common-5.7.29-1.el7.x86_64.rpm
wget http://mirrors.ustc.edu.cn/mysql-ftp/Downloads/MySQL-5.7/mysql-community-client-5.7.29-1.el7.x86_64.rpm
rpm -ivh mysql-community-server-5.7.29-1.el7.x86_64.rpm
rpm -ivh mysql-community-common-5.7.29-1.el7.x86_64.rpm
rpm -ivh mysql-community-libs-5.7.29-1.el7.x86_64.rpm
rpm -ivh mysql-community-client-5.7.29-1.el7.x86_64.rpm




