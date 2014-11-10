#!/bin/bash -e
myRole=$1

# Galaxy requires more metadata
# ansible-galaxy init $myRole

mkdir -p $myRole/{handlers,tasks,vars}
for dir in `ls $myRole`
do
    echo '---' > $myRole/$dir/main.yml
done

