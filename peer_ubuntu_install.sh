#!/bin/bash
if [ "$(id -u)" != "0" ]; then  
   echo "This script must be run as root or with sudo cmd" 1>&2  
   exit 1  
   else
   URS=$(echo $HOME)
    installcmd() {
        
        if ! which git > /dev/null 2>&1; then
        cd $URS
        apt-get update -y && apt-get install git -y
        fi

URS=$(echo $HOME)
cd $URS
        rm -rf $URS/peer-node-installer
        if [ ! -d $URS/peer-node-installer ]
            then
                git clone  https://github.com/PEER-Inc/peer-node-installer.git 
        fi 
        rm -rf $URS/.peer
        if [ ! -d $URS/.peer ]
            then
                mkdir $URS/.peer
                cd $URS/peer-node-installer
                cp  customSpecRaw.json $URS/.peer/customSpecRaw.json
                chmod +x peer
                cp peer /usr/bin/
            else
                cd peer-node-installer
		echo $PWD
                    if [ ! -f $URS/.peer/customSpecRaw.json ]
                        then
                            cd $URS/peer-node-installer
                            mv  customSpecRaw.json $URS/.peer/customSpecRaw.json
                            chmod +x peer
                            cp peer /usr/bin/
                    fi      
        fi
 }
 
peercmd(){
    if [ -x /usr/bin/peer ]
       	        then
       	        cd $URS/peer-node-installer
                chmod +x peer
                cp peer /usr/bin/
                echo "peer is ready to run"
            else
                cd $URS/peer-node-installer
                chmod +x peer
                cp peer /usr/bin/
     fi
    
}
    checkdir(){
       mkdir /data
        }

    listdir(){
        cd /data
        echo "Last node name "
        for i in $(find /data -name chains -type d |cut -f3 -d '/'); do echo -e " ${i}" ; done
       # find /data -name chains -type d |cut -f3 -d '/'
}

    peerconnect(){
        while [ -z $x ]
            do
                echo "Enter Your Node Name: "
                read x

            if [ -z "$x" ]
            then
                 echo "Please enter your node name it can't be null"
            fi
            done
        num=$(( $RANDOM % 5 + 1 ))
        echo $num
case $num in
	1)
	peer --base-path /data/"${x}" --chain $URS/.peer/customSpecRaw.json --port 30333 --ws-external --rpc-external --rpc-cors all --no-telemetry --validator --rpc-methods Unsafe --name "${x}" --bootnodes /ip4/44.226.191.229/tcp/30333/p2p/12D3KooWQoXbnbm5ve83Pvjw2qAViW5DC6cNGMNHmomovCBxkjGY	
		;;
	2)
	peer --base-path /data/"${x}" --chain $URS/.peer/customSpecRaw.json --port 30333 --ws-external --rpc-external --rpc-cors all --no-telemetry --validator --rpc-methods Unsafe --name "${x}" --bootnodes /ip4/35.163.7.4/tcp/30333/p2p/12D3KooWSzCM3iq2XVSH3BbVTGkgHa3SmQAyX8pW5oNuzo2wWFvb
		;;
	3)
	peer --base-path /data/"${x}" --chain $URS/.peer/customSpecRaw.json --port 30333 --ws-external --rpc-external --rpc-cors all --no-telemetry --validator --rpc-methods Unsafe  --name "${x}" --bootnodes /ip4/35.162.207.217/tcp/30333/p2p/12D3KooWPQgv1rbY94anxvdGkVq4fGvWnRZVnTudXQp6mbxX2ef1
		;;
	4)
	peer --base-path /data/"${x}" --chain $URS/.peer/customSpecRaw.json  --port 30333 --ws-external --rpc-external --rpc-cors all --no-telemetry --validator --rpc-methods Unsafe --name "${x}" --bootnodes /ip4/54.151.34.111/tcp/30333/p2p/12D3KooWPJARcGrcQjjjbDawETmGUSA5NaiWvDtRkjNvjS1T3zMG
		;;
	5)
	peer --base-path /data/"${x}" --chain $URS/.peer/customSpecRaw.json --port 30333 --ws-external --rpc-external --rpc-cors all --no-telemetry --validator --rpc-methods Unsafe --name "${x}" --bootnodes /ip4/52.8.49.96/tcp/30333/p2p/12D3KooWSQvqso1VYppX1nowqukwE9dQSM2GLordeBumE8PXLLXG
		;;
esac
}

dir=/data

    if [ ! -d  $dir ]
        then
	        checkdir
            if [ -x /usr/bin/peer ]
       	        then
                echo "peer is ready to run"
            else
                installcmd
                peercmd
            fi
                peerconnect 
                exit 1 
    else
            installcmd	
            peercmd
            listdir
            peerconnect 
            exit 1        
    fi
 fi  

