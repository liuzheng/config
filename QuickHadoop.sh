#!/bin/bash
# coding: utf-8
# Copyright (c) 2014
# Gmail:liuzheng712
#


if [ -z $HADOOP_HOME ]; then
  read -p "Can't Find HADOOP_HOME, Where is it?(Enter with blank is exit):" HADOOP_HOME
  if [ -z $HADOOP_HOME ];then
    exit 0
  fi
fi

HADOOP_CONFIG=$HADOOP_HOME/etc/hadoop

echo "HADOOP_HOME is " $HADOOP_HOME
cat $HADOOP_CONFIG/slaves
read -p "Which slave you want to delete?(use ',' split):" slaves
if [ `cat $HADOOP_CONFIG/hdfs-site.xml | grep 'dfs.hosts.exclude'` ];then
  echo 'have dfs.hosts.exclude'
  i=0
  while read line
  do
    if [ `echo $line | grep '<name>'` ];then
      name[$i]=`echo $line | awk -F"[><]" '{print $3}'`
    elif [ `echo $line | grep '<value>'` ];then
      value[$i]=`echo $line | awk -F"[><]" '{print $3}'`
      if [ ${name[$i]} = "dfs.hosts.exclude" ];then
        echo ${value[$i]}
        excludes_path=${value[$i]}
      fi
      i=`expr $i + 1`
    fi
  done < $HADOOP_CONFIG/hdfs-site.xml

else
  read -p "Don't have dfs.hosts.exclude path?(Enter Use $HADOOP_CONFIG/excludes)" excludes_path
  if [ -z excludes_path ];then
    sed -i "/<\/configuration>/i<property>\n<name>dfs.hosts.exclude</name>\n<value>$excludes_path</value>\n</property>" $HADOOP_CONFIG/hdfs-site.xml
  else
    sed -i "/<\/configuration>/i<property>\n<name>dfs.hosts.exclude</name>\n<value>$HADOOP_CONFIG/excludes</value>\n</property>" $HADOOP_CONFIG/hdfs-site.xml
    excludes_path=$HADOOP_CONFIG/excludes
  fi
  echo "adding $excludes_path ..."
fi
IFS=","
arr=($slaves)
for slave in ${arr[@]}
do
  echo $slave >> $excludes_path
done
echo '' >> $excludes_path
sed -i '/^$/d' $excludes_path
cat $excludes_path | awk '!a[$1]++' > /tmp/excludes
mv /tmp/excludes $excludes_path

$HADOOP_HOME/bin/hadoop dfsadmin -refreshNodes

while true
do
if [ `$HADOOP_HOME/bin/hadoop dfsadmin -report|grep "Decommission in progress" | wc -l` -eq 0 ];then
  if [ `$HADOOP_HOME/bin/hadoop dfsadmin -report| grep "Decommissioned" | wc -l` -eq 0 ];then
    echo 'Maybe No Machine needs to shutdown'
    echo "Let check the excludes($excludes_path):"
    echo "cat "$excludes_path | sh 
    break
  else
    echo 'You can turn down the Machine:'
    echo "cat "$excludes_path | sh 
    break
  fi
fi
done

