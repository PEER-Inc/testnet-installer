#!/bin/bash
if [ "$(id -u)" != "0" ]; then  
   echo "This script must be run as root or with sudo cmd" 1>&2  
   exit 1  
   else
   URS=$(echo $HOME)
    installcmd() {
        
        if ! which git > /dev/null 2>&1; then
        cd $URS
        brew update -y && brew install git -y
        fi

URS=$(echo $HOME)
cd $URS
        if [ ! -d $URS/peer-node-installer ]
            then
                git clone  https://github.com/PEER-Inc/peer-node-installer.git
 		cd  $URS/peer-node-installer  
		git checkout Mac_Binary
        fi 

        if [ ! -d $URS/.peer ]
            then
                mkdir $URS/.peer
                cd $URS/peer-node-installer
                cp  customSpecRaw.json $URS/.peer/customSpecRaw.json
                chmod +x peer
                if [ -d /usr/local/bin/ ]
       	        then
                    cp peer /usr/local/bin/
                else
                    mkdir -p /usr/local/bin/
                    cp peer /usr/local/bin/
                fi
            else
		echo $PWD
                    if [ ! -f $URS/.peer/customSpecRaw.json ]
                        then
                            cd $URS/peer-node-installer
                            mv  customSpecRaw.json $URS/.peer/customSpecRaw.json
                            chmod +x peer
                    if [ -d /usr/local/bin/ ]
       	            then
                        cp peer /usr/local/bin/
                    else
                        mkdir -p /usr/local/bin/
                        cp peer /usr/local/bin/
                    fi
                    fi      
        fi
 }
 
peercmd(){
    if [ -x /usr/bin/peer ]
       	        then
                echo "peer is ready to run"
            else
                cd $URS/peer-node-installer
                chmod +x peer
                                if [ -d /usr/local/bin/ ]
       	        then
                    cp peer /usr/local/bin/
                else
                    mkdir -p /usr/local/bin/
                    cp peer /usr/local/bin/
                fi
     fi
    
}
    checkdir(){
       mkdir /data
        }

    listdir(){
        cd /opt
        for i in $(find /opt -name chains -type d |cut -f3 -d '/'); do echo "Last Dir. \n ${i}" ; done
       # find /opt -name chains -type d |cut -f3 -d '/'
}

    peerconnect(){
        echo "Enter Your Node Name: "
        read x
        num=$(( $RANDOM % 5 + 1 ))
case $num in
	1)
	peer --base-path /opt/"${x}" --chain $URS/.peer/customSpecRaw.json --port 30333 --ws-external --rpc-external --rpc-cors all --no-telemetry --validator --rpc-methods Unsafe --name "${x}" --bootnodes /ip4/44.224.219.49/tcp/30333/p2p/12D3KooWNCsCnx8t3gjSNi7QasMD3RnH4bsAGPuvGgXyqUVmVzZv
		;;
	2)
	peer --base-path /opt/"${x}" --chain $URS/.peer/customSpecRaw.json --port 30333 --ws-external --rpc-external --rpc-cors all --no-telemetry --validator --rpc-methods Unsafe --name "${x}" --bootnodes /ip4/3.98.162.251/tcp/30333/p2p/12D3KooWFjvYnJMiCdESbcxhcrYA9WgtvCRZqJVVCazE4ccXbQQZ
		;;
	3)
	peer --base-path /opt/"${x}" --chain $URS/.peer/customSpecRaw.json --port 30333 --ws-external --rpc-external --rpc-cors all --no-telemetry --validator --rpc-methods Unsafe  --name "${x}" --bootnodes /ip4/52.221.105.119/tcp/30333/p2p/12D3KooWAuZ626pbeivT3CfF5yk26aAdD4apZHCW6ftzz1hJCrcS
		;;
	4)
	peer --base-path /opt/"${x}" --chain $URS/.peer/customSpecRaw.json  --port 30333 --ws-external --rpc-external --rpc-cors all --no-telemetry --validator --rpc-methods Unsafe --name "${x}" --bootnodes /ip4/3.109.243.150/tcp/30333/p2p/12D3KooWQn9w8AdBSBkUkAkSjK4TDcZT8LB2pfT8FUr1CAqsfBtE
		;;
	5)
	peer --base-path /opt/"${x}" --chain $URS/.peer/customSpecRaw.json --port 30333 --ws-external --rpc-external --rpc-cors all --no-telemetry --validator --rpc-methods Unsafe --name "${x}" --bootnodes /ip4/15.188.249.191/tcp/30333/p2p/12D3KooWMBSafZwTdxcBnuWyaNWBqsBrjzazc6B8PqRXtQXL8iCc
		;;
esac
}

dir=/opt

    if [ ! -d  $dir ]
        then
	        checkdir
            if [ -x /usr/local/bin/peer ]
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
            if [ -x /usr/local/bin/peer ]
       	        then
                echo "peer is ready to run"
            else
                installcmd
                peercmd
            fi
            peercmd
            listdir
            peerconnect 
            exit 1        
    fi
 fi 
