mv MariaDB.repo /etc/yum.repos.d/MariaDB.repo

rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
yum install MariaDB-server MariaDB-client