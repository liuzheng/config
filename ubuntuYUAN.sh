#!/bin/bash
#------------------------------------------------------------------------#
MIRRORS_LIST=./.ubuntu_mirrors.list         #文件名和存储位置都可以改，存放所有的源列表
MIRRORS_SCORED=./.ubuntu_mirrors            #文件名和存储位置都可以改，存放测试后速度快的几个源
VERSION=`lsb_release -a | grep 'Codename' | awk '{print $2}'`                                #ubuntu版本发生变化时，就更改这个"hardy"为相应的版本号
if [ `getconf LONG_BIT` == 32 ]; then
ARCHITECTURE="i386"
else
ARCHITECTURE="amd64"
fi

TIMEOUT=20    
CONCURRENT_PROCESSES=30
#------------------------------------------------------------------------#
function cleanup()
{

    if [ -n "$1" -a -d "$1" ]; then
        rm -rf "$1"
    fi
}
check_mirror()
{
    local mirror="$1"
    local url="$mirror/dists/$VERSION/main/binary-$ARCHITECTURE/Packages.gz"
    local state=$(mktemp -p "$workdir")
    local CURL="curl -w %{speed_download} -s -f -m $TIMEOUT -N -o $state"
    local speed=$($CURL $url)
    if [ -f "$state" ];then
        local resp=$(hexdump $state | head | grep '8b1f 0008')
        if [ "$resp" != "" ]; then
            echo $mirror $speed
        fi
        rm -f $state
    fi
}
backup_sources()
{
    echo "Backup your sources.list."
    local -i num=0
    while [ -e /etc/apt/sources.list.$num ];do
       num=$num+1;      
    done
    sudo mv /etc/apt/sources.list /etc/apt/sources.list.$num
}
output_sources()
{
    local COMP="main restricted universe multiverse"
    local mirrors="$1"
    local tmp=$(mktemp) 
    local mirror
    for mirror in $mirrors; do
        echo "deb $mirror $VERSION $COMP" >> $tmp
        echo "deb $mirror ${VERSION}-security $COMP" >> $tmp
        echo "deb $mirror ${VERSION}-updates $COMP" >> $tmp
        echo -n "Do you want to include source packages? [Y/n]"
        local yn 
        read yn
        if [ -z $yn ]; then
          yn="y"
        fi
        if [ "$yn" == "y" ]; then
            echo "deb-src $mirror $VERSION $COMP" >> $tmp
            echo "deb-src $mirror ${VERSION}-security $COMP" >> $tmp
            echo "deb-src $mirror ${VERSION}-updates $COMP" >> $tmp
        fi
        echo >> $tmp
    done
    if [ -f "$tmp" ]; then
        echo -n "Do you want to continue? [Y/n]"
        local yn
        read yn
        if [ -z $yn ]; then
          yn="y"
        fi
        if [ ! "$yn" == "y" ]; then
            exit 0
        fi
        backup_sources
        sudo mv "$tmp" /etc/apt/sources.list
        echo "Your sources has been updated, and maybe you want to run \"sudo apt-get update\" now. ";
        echo -n "sudo apt-get update now? [Y/n]"
        read yn 
        if [ -z $yn ]; then
          yn="y"
        fi
        if [ "$yn" == "y" ]; then
          echo "sudo apt-get update"
          sudo apt-get update
        fi
    else
        echo "some badthing has happen...."
        exit 1
    fi
    if [ -f "$tmp" ]; then
        rm -f "$tmp"
    fi
}
choose_mirror()
{
    if [ ! -f "$MIRRORS_SCORED" ]; then
        exit 1
    fi
    local mirrors speeds
    mirrors=$(cat $MIRRORS_SCORED | sed -n "$1 p" | awk '{print $1}')
    speeds=$( cat $MIRRORS_SCORED | sed -n "$1 p" | awk '{print $2}')
    if [ "$mirrors" != "" ]; then
        echo "We have found the top one mirror for you: "
        echo "$mirrors" 
        echo "The speed is:"
        echo "$speeds"
        output_sources "$mirrors"
        exit 0
    else
        echo "Why I can't find the best one for you?"
    fi
}
show_help()
{
    echo "Usage 1:"
    echo "`basename $0` [hardy|breezy]"
    echo "hardy is the default version"
    echo "Example:"
    echo "`basename $0` breezy"
    echo 
    echo "Usage 2:"
    echo "`basename $0` n"
    echo "n is a number"
    echo "Example:"
    echo "`basename $0` 3"
    echo "Which will choose the 3th mirror from your mirrors as your source"
}
# kill background processes before exit
function kill_bgpid()
{
    local pid
    for pid in ${pids[@]}; do
        kill $pid &> /dev/null
    done
}
#------------------------------------------------------------------------
#------------------------------------------------------------------------
# load mirrors
if [ ! -f "$MIRRORS_LIST" ]; then
    echo "NO ubuntu mirrors list found in $MIRRORS_LIST."
    exit 1
fi
MIRRORS=$(cat "$MIRRORS_LIST")
declare -i counts=$(echo "$MIRRORS"|wc -l)
if (($counts<2)); then
    echo "too few mirrors got from $MIRRORS_LIST"
    exit 1
fi
# parse command line option
if (($#>=1)); then
    if [ "$1" == "dapper" -o "$1" == "breezy" ]; then
        VERSION=$1
    elif (("$1">0)); then
        choose_mirror $1
    else
        show_help
        exit 1
    fi
fi
# The mirror site and the download speed were stored here
workdir=$(mktemp -d /tmp/`basename $0`.XXXXXX)
timer=$(mktemp -p $workdir)
trap "cleanup $workdir" EXIT
echo "Setting $VERSION for you ...";
exec 2>/dev/null        # close standard error output
declare -a pids         # store backgound processes ids
trap 'echo do some cleaning work ....; kill_bgpid; exit 1' INT
declare -i begin=1
declare -i end=$CONCURRENT_PROCESSES
if [ $n -le $CONCURRENT_PROCESSES ]; then
    end=$counts
fi
declare -i num=0
while (($begin <= $counts)); do
    for mirror in $(echo "$MIRRORS" | sed -n "$begin,$end p"); do
        (check_mirror $mirror >> $timer) & 
        pids[$num]=$!
        let "num++"
    done
    wait
    # next loop
    begin=$(($end + 1))    
    end=$(($end + $CONCURRENT_PROCESSES - 1))
    if (( $end > $counts ));then
        end=$counts
    fi
done
if [ -f "$timer" ]; then
    declare -i num=0
    while [ -e $MIRRORS_SCORED.$num ];do
       num=$num+1;      
    done
    mv $MIRRORS_SCORED $MIRRORS_SCORED.$num
    cat $timer | sort -k 2 -r -g > $MIRRORS_SCORED
fi
choose_mirror 1
exit 0
