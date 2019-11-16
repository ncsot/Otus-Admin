yum -y update
yum -y groupinstall "Development-Tools"
yum -y install ncurses-devel bison flex elfutils-libelf-devel openssl-devel zlib-devel binutils-devel bc
yum install -y yum-utils
yum install -y git