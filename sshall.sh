#!/bin/bash
node=(master slave1 slave2 slave3 slave4 slave5 slave6)  # hostname for each node
username=hadoop            # username to be interconnected
homename=$username        # home dir, i.e. home/zhangyang
if [ "$username" = "root" ];
then
        homename=root
else
        homename=home/$username
fi

for((i=0; i<${#node[*]}; i++))
do
        ssh $username@${node[i]} 'ssh-keygen -t rsa -f /'$homename'/.ssh/id_rsa'
done
#cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

echo "batch authorized_keys created..."
echo "start scp..."

#scp node003:/$homename/.ssh/authorized_keys /$homename/.ssh/node003.key
for((i=0; i<${#node[*]}; i++))
do
        scp $username@${node[i]}:/$homename/.ssh/id_rsa.pub /$homename/.ssh/${node[i]}.key
        echo "scp from ${node[i]} finished..."
done

echo "append key to authorized_keys..."
for((i=0; i<${#node[*]}; i++))
do
        cat /$homename/.ssh/${node[i]}.key >> /$homename/.ssh/authorized_keys
        echo "append ${node[i]}.key finished..."
done

cat /$homename/.ssh/authorized_keys | awk '!a[$2]++' > /tmp/authorized_keys
mv /tmp/authorized_keys /$homename/.ssh/authorized_keys

echo "append all key finished..."
loop=${#node[*]}
let subloop=loop-1
echo "starting scp complete authorized_keys to ${node[1]}~${node[subloop]}"
for((i=1; i<${#node[*]}; i++))
do
        scp /$homename/.ssh/authorized_keys ${node[i]}:/$homename/.ssh/authorized_keys.tmp
        ssh $username@${node[i]} -C "cat ~/.ssh/authorized_keys.tmp >> ~/.ssh/authorized_keys | cat ~/.ssh/authorized_key | sort > /tmp/authorized_keys && mv /tmp/authorized_keys ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
        echo "scp to ${node[i]} finished..."
done
echo "scp all nodes finished..."

# delete intermediate files
rm -rf /$homename/.ssh/*.key
echo "all configuration finished..."
