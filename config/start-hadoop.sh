#!/bin/bash

#启动HDFS
echo -e "\n"
$HADOOP_HOME/sbin/start-dfs.sh

#启动Yarn
echo -e "\n"
$HADOOP_HOME/sbin/start-yarn.sh
echo -e "\n"

