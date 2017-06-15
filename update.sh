#!/bin/bash
set -e

# set the correct timezone
timedatectl set-timezone "Europe/Berlin"

# upgrade all packages
apt-get update -y

# install nodejs
node_file=node-v6.11.0-linux-armv6l.tar.xz
node_dir=$(basename $node_file .tar.xz)
if [ ! -e /usr/lib/$node_dir ];then
    curl https://nodejs.org/dist/v6.11.0/$node_file -o $node_file
    tar xJf $node_file -C /usr/lib/
    pushd .
    cd /usr/bin
    if [ -e /usr/bin/node ]; then
        rm -f /usr/bin/node
        rm -f /usr/bin/npm
    fi
    ln -s /usr/lib/$node_dir/bin/node
    ln -s /usr/lib/$node_dir/bin/npm
    popd
fi

# install pm2
if ! npm list pm2 -g ; then
    npm install pm2 -g
fi


# install update-barcodescanner
if [ ! -e /home/pi/barcodescanner-js ];then
    git clone https://github.com/franke1276/barcodescanner-js.git /home/pi/barcodescanner-js
fi

install -m 700 ./update-barcodescanner /usr/sbin/update-barcodescanner
/usr/sbin/update-barcodescanner

/usr/lib/node-v6.11.0-linux-armv6l/lib/node_modules/pm2/bin/pm2 startup
