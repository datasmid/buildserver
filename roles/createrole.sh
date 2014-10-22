#!/bin/bash -e
myRole=$1
mkdir -p $myRole/{handlers,tasks,vars}
for dir in `ls $myRole`
do
    echo '---' > $myRole/$dir/main.yml
done
