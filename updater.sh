#!/usr/bin/bash

sudo apt update

for target in `sudo apt list --upgradable`
do
    if [[ ${target} =~ ^.*/.*$ ]];then
        list+=(`echo $target | sed -e "s|\(^.*\)/.*$|\1|"`)     #add name to update
    fi
done

echo -e "install list(${#list[@]}): \n${list[@]}\n"     #show update list

read -p "continue? (y/n) > " response   #wait for input
echo $response

if [ "$response" = "y" ] || [ "$response" = "Y" ] || [ "$response" = "" ];then
    replay=0
    for i in ${list[@]}
    do
        if [ "$replay" = "0" ] || [ "$replay" = "y" ] || [ "$replay" = "Y" ] || [ "$replay" = "" ] || [ "$replay" = "n" ];then #when !(replay > 0)
            read -p "continue to install \"$i\" ? (y/n/stop/[count]) > " replay
        fi
        if [ "$replay" = "y" ] || [ "$replay" = "Y" ] || [ "$replay" = "" ];then    #install
            echo "installing $i ..."
            sudo apt install $i -y #install
            echo "done!"
        elif [[ $replay =~ ^[1-9]*$ ]];then
            echo "installing $i ..."
            sudo apt install $i -y #install
            echo "done!"
            replay=$(($replay-1))
        elif [ "$replay" = "stop" ];then
            echo "stop installing"
            break
        else
            echo "skip \"$i\""
            continue
        fi
    done
    echo "finish"
else
    echo "canceled"
fi