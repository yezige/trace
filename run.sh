#!/bin/bash

if [ ! -f "./besttrace4linux/besttrace" ]; then
    # get besttrace4linux
    wget https://cdn.ipip.net/17mon/besttrace4linux.zip

    # uzip
    mkdir -p besttrace4linux
    if [ -z $(command -v unzip) ]; then
        echo "Need install unzip: \"sudo apt-get install zip\" or \"sudo yum install zip\""
    fi
    unzip -o besttrace4linux.zip -d ./besttrace4linux

    chmod +x ./besttrace4linux/besttrace
fi

cd besttrace4linux

# clear

function green() {
    printf "\033[42m$1\033[0m\n"
}

ip_list=(219.141.147.210 202.106.50.1 221.179.155.161 202.96.209.133 210.22.97.1 211.136.112.200 58.60.188.222 210.21.196.6 120.196.165.24 202.112.14.151)
ip_addr=(北京电信 北京联通 北京移动 上海电信 上海联通 上海移动 深圳电信 深圳联通 深圳移动 成都教育网)

for i in {0..9}; do
    green ${ip_addr[$i]}
    ./besttrace -q 1 ${ip_list[$i]} | awk 'BEGIN {
        FS="  "
    }
    function hl_AS(msg) {
        as_list["AS4134"]="AS4134,163"
        as_list["AS4809"]="AS4809,CN2"
        flag=0
        for(hl in as_list){
            if(msg in as_list){
                flag=1;
            }
        }
        if(flag == 1)
        {
            printf "\033[35m"as_list[msg]"\033[0m";
        }
        else
        {
            printf msg;
        }
    }
    {
        printf $1FS$2FS$3FS
        hl_AS($4)
        printf FS$5FS$6"\n"
    }'
done
