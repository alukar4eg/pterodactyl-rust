#!/bin/bash
sleep 2

cd /home/container

# Update Rust Server
./steam/steamcmd.sh +login anonymous +force_install_dir /home/container +app_update 258550 +quit

# Replace Startup Variables
MODIFIED_STARTUP=`eval echo $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')`
echo ":/home/container$ ${MODIFIED_STARTUP}"

if [ -f OXIDE_FLAG ]; then
    echo "Updating OxideMod..."
    curl -sSL "https://dl.bintray.com/oxidemod/builds/Oxide-Rust.zip" > oxide.zip
    unzip -o -q oxide.zip
    rm oxide.zip
    echo "Done updating OxideMod!"
fi

# Fix for Rust not starting
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)
#fix DNS
echo nameserver 91.214.70.1 > /etc/resolv.conf

# Run the Server
node /wrapper.js "${MODIFIED_STARTUP}"
