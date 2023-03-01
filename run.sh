#!/bin/bash

# ---基础函数---
install() {
    pkg=$1
    if grep -Eqii "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release; then
        DISTRO='CentOS'
        PM='yum'
    elif grep -Eqi "Red Hat Enterprise Linux Server" /etc/issue || grep -Eq "Red Hat Enterprise Linux Server" /etc/*-release; then
        DISTRO='RHEL'
        PM='yum'
    elif grep -Eqi "Aliyun" /etc/issue || grep -Eq "Aliyun" /etc/*-release; then
        DISTRO='Aliyun'
        PM='yum'
    elif grep -Eqi "Fedora" /etc/issue || grep -Eq "Fedora" /etc/*-release; then
        DISTRO='Fedora'
        PM='yum'
    elif grep -Eqi "Debian" /etc/issue || grep -Eq "Debian" /etc/*-release; then
        DISTRO='Debian'
        PM='apt'
    elif grep -Eqi "Ubuntu" /etc/issue || grep -Eq "Ubuntu" /etc/*-release; then
        DISTRO='Ubuntu'
        PM='apt'
    elif grep -Eqi "Raspbian" /etc/issue || grep -Eq "Raspbian" /etc/*-release; then
        DISTRO='Raspbian'
        PM='apt'
    else
        DISTRO='unknow'
        PM='unknow'
    fi
    echo "当前系统: ${DISTRO}"

    if [ "$PM" = 'yum' ]; then
        echo "执行 yum install -y ${pkg} 命令"
        yum install -y $pkg
    elif [ "$PM" = 'apt' ]; then
        echo "执行 apt-get install -y ${pkg} 命令"
        apt-get update
        apt-get install -y $pkg
    else
        echo "系统不受支持, 脚本只支持 Linux 系统"
        exit 1
    fi
}

function green() {
    printf "\033[42m$1\033[0m\n"
}
# ---基础函数---

# ---主流程---
workdir=/tmp/besttrace4linux

# 计算当前平台
case $(uname -m) in
i686* | i386*)
    plat="32"
    ;;
x86_64)
    plat=""
    ;;
aarch64* | arm | armv8b | armv8l)
    plat="arm"
    ;;
amd64)
    plat="bsd"
    ;;
*)
    plat=""
    ;;
esac
echo "当前平台：${plat}"
exec_name=besttrace${plat}
echo "可执行文件：${exec_name}"

if [ ! -f "${workdir}/besttrace" ]; then
    mkdir -p ${workdir}

    # get besttrace4linux
    if [ ! -f "${workdir}/besttrace4linux.zip" ]; then
        if [ -z $(command -v wget) ]; then
            install wget
        fi
        wget -P $workdir https://github.com/yezige/trace/raw/main/besttrace4linux.zip
    fi

    # uzip
    if [ -z $(command -v unzip) ]; then
        install unzip
    fi
    unzip -o ${workdir}/besttrace4linux.zip -d ${workdir}

    chmod +x ${workdir}/$exec_name
fi

clear

ip_list=(219.141.147.210 202.106.50.1 221.179.155.161 202.96.209.133 210.22.97.1 211.136.112.200 58.60.188.222 210.21.196.6 120.196.165.24 202.112.14.151)
ip_addr=(北京电信 北京联通 北京移动 上海电信 上海联通 上海移动 深圳电信 深圳联通 深圳移动 成都教育网)

# 增加入参到待traceroute列表
if [ $# -ne 0 ]; then
    ip_list_add=()
    ip_addr_add=()
    for i in $*; do
        ip_list_add[${#ip_list_add[*]}]=$i
        ip_addr_add[${#ip_addr_add[*]}]=$i
    done
    ip_list=(${ip_list_add[*]} ${ip_list[*]})
    ip_addr=(${ip_addr_add[*]} ${ip_addr[*]})
fi

for i in "${!ip_list[@]}"; do
    green ${ip_addr[$i]}
    ${workdir}/$exec_name -q 1 ${ip_list[$i]} | awk 'BEGIN {
        FS="  "
    }
    function hl_AS(msg) {
        as_list["AS4134"]="AS4134,电信163"
        as_list["AS4809"]="AS4809,电信CN2"
        as_list["AS4837"]="AS4837,联通169"
        as_list["AS9929"]="AS9929,联通A网"
        as_list["AS9808"]="AS9808,CMNET移动骨干"
        as_list["AS23764"]="AS10099,CTG电信国际"
        as_list["AS10099"]="AS10099,CUG联通国际"
        as_list["AS58453"]="AS58453,CMI移动国际"
        as_list["AS4538"]="AS4538,CERNET教育网"
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

# ---speedtest-cli
# 校验python
py=python
if [ -z $(command -v python) ]; then
    if [ -z $(command -v python3) ]; then
        install python3
    fi
    py=python3
fi
# 下载speedtest.py
wget -O /tmp/speedtest.py https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py

$py /tmp/speedtest.py

# ---主流程---
