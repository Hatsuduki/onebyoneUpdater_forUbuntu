#!/usr/bin/bash

sudo apt update

for target in `sudo apt list --upgradable`
do
    if [[ ${target} =~ ^.*/.*$ ]];then
        
        list+=(`echo $target | sed -e "s|\(^.*\)/.*$|\1|"`)
        
    fi
done


#echo "hello world"
echo -e "install list(${#list[@]}): \n${list[@]}\n"

read -p "continue? (y/n) > " response
echo $response

if [ "$response" = "y" ] || [ "$response" = "Y" ] || [ "$response" = "" ];then
    for i in ${list[@]}     #幾つかまとめてインストールできるようにする
    do
        read -p "continue to install \"$i\" ? (y/n/stop) > " replay
        if [ "$replay" = "y" ] || [ "$replay" = "Y" ] || [ "$replay" = "" ];then
            echo "installing $i ..."
            sudo apt install $i -y #install
            echo "done!"
        elif [ $replay = "stop" ];then
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