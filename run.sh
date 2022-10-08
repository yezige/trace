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
        as_list["AS4134"]="AS4134,电信163"
        as_list["AS4809"]="AS4809,CN2"
        as_list["AS4837"]="AS4837,联通169"
        as_list["AS9929"]="AS9929,联通A网"
        as_list["AS10099"]="AS10099,联通国际"
        as_list["AS58453"]="AS58453,CMI"
        as_list["AS9808"]="AS9808,CMNET"
        as_list["AS4538"]="AS4538,CERNET"
        as_list["AS9929"]="AS9929,CU-VIP"
        as_list["AS2914"]="AS2914,NTT"
        as_list["AS2497"]="AS2497,IIJ"
        as_list["AS2516"]="AS2516,KDDI"
        as_list["AS4725"]="AS4725,SoftBank"
        as_list["AS3491"]="AS3491,PCCW"
        as_list["AS9269"]="AS9269,HKBN"
        as_list["AS4635"]="AS4635,HKIX"
        as_list["AS4760"]="AS4760,HKT"
        as_list["AS4637"]="AS4637,Telstra"
        as_list["AS64050"]="AS6405,BGPNET"
        as_list["AS6939"]="AS6939,HE"
        as_list["AS174"]="AS174,Cogent"
        as_list["AS3356"]="AS3356,LEVEL3"
        as_list["AS3257"]="AS3257,GTT"
        as_list["AS7018"]="AS7018,ATT"
        as_list["AS1239"]="AS1239,T-Mobile"
        as_list["AS1299"]="AS1299,Arelion"
        as_list["AS6453"]="AS6453,TATA"
        as_list["AS6830"]="AS6830,Liberty"
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
    function hl_5943(msg) {
        ip_list["59.43.*"]=msg
        ip_list["202.97.*"]=msg
        flag=0
        for(hl in ip_list){
            if(match(msg, hl)){
                flag=1;
            }
        }
        if(flag == 1)
        {
            printf "\033[35m"msg"\033[0m";
        }
        else
        {
            printf msg;
        }
    }
    {
        printf $1FS
        hl_5943($2)
        printf FS$3FS
        hl_AS($4)
        printf FS$5FS$6"\n"
    }'
done
