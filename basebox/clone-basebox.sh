#/bin/bash -ex
myClone=$1
if [ -z $myClone ]
then
    echo "Usage $0 <newname>"
    exit 1
fi
cd ..
mkdir $myClone
cp basebox/Vagrantfile $myClone
cp basebox/basebox-playbook.yml $myClone/$myClone-playbook.yml

sed -e "s/basebox/$myClone/" -i '' $myClone/Vagrantfile
sed -e "s/#vb.name/vb.name/" -i '' $myClone/Vagrantfile
