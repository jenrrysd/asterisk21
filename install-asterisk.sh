#!/bin/bash

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

#make menuselect

# Seleccionamos los módulos automáticamente
menuselect/menuselect --enable chan_ooh323 menuselect.makeopts
menuselect/menuselect --enable CORE-SOUNDS-ES-GSM menuselect.makeopts

#### marcar los siguinentes para su instalación
#Add-ons (See README-addons.txt) > chan_ooh323
#Core Sound Packages > CORE-SOUNDS-ES-GSM
#Save & Exit

make
make install
make samples
make config

asterisk -v
asterisk -rv

