#!/bin/bash

## este script corre sobre debian12 y debeian13 en modo root

apt-get update -y
apt-get install linux-headers-$(uname -r) -y
apt-get install wget vim -y
cd /usr/src
wget https://downloads.asterisk.org/pub/telephony/dahdi-linux-complete/dahdi-linux-complete-current.tar.gz

wget https://downloads.asterisk.org/pub/telephony/libpri/libpri-1-current.tar.gz

wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-21-current.tar.gz

tar -zxf asterisk-21-current.tar.gz

cd /usr/src/asterisk-21.*.*/contrib/scripts/

./install_prereq install

cd /usr/src

tar -xf dahdi-linux-complete-current.tar.gz

cd dahdi-linux-complete-3.*/

make
make install 
make install-config

cd /usr/src
tar -xf libpri-1-current.tar.gz

cd libpri-1.6.*/

make
make install

cd /usr/src/asterisk-21.*.*/
./configure

# Paso 2: Habilitar módulos específicos automáticamente
menuselect/menuselect \
    --enable chan_ooh323 \
    --enable CORE-SOUNDS-ES-GSM \
    --enable codec_opus \
    --enable format_mp3 \
    --enable app_meetme \
    --enable res_http_websocket \
    menuselect.makeopts

# Paso 3: Compilación e instalación
make -j$(nproc)
make install
make samples
make config

systemctl start asterisk
systemctl enable asterisk

asterisk -rv

