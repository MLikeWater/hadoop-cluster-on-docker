# hadoop-cluster-on-docker
Run Hadoop Cluster within Docker Containers

Section A:


For Example: 3 Nodes Hadoop Cluster(Default)

Step 1. pull docker image
sudo docker pull kjiangshouzhuang/hadoop2.7.3-cluster-on-docker:1.0

Step 2. clone github repository
git clone https://github.com/jiangshouzhuang/hadoop-cluster-on-docker


Step 3. create hadoop network
sudo docker network create --driver=bridge hadoop

Step 4. start container
cd hadoop-cluster-on-docker
chmod +x *
sudo ./start-container.sh

output:
start master container...
start slave1 container...
start slave2 container...
root@master:/# 

Note: Hadoop cluster with 1 master and 2 slaves on Docker 3 Containers

Step 5. start hadoop
root@master:/# start-hadoop.sh(including start hdfs and yarn)

or

root@master:/# start-dfs.sh
root@master:/# start-yarn.sh

Step 6. run wordcount
root@master:/# run-wordcount.sh

output:
input file1.txt:
Hello Hadoop

input file2.txt:
Hello Docker

wordcount output:
Docker	1
Hadoop	1
Hello	2

=========================================

Section B:

The size of Hadoop cluster can be customized.
as follows:
Step 1. pull docker images and clone github repository
do Step 1~3 like Section A

Step 2. rebuild docker image
chmod +x *
sudo ./resize-cluster.sh 5

Note: 
1. You shuld put hadoop-2.7.3.tar.gz and jdk-7u80-linux-x64.tar.gz in the directory named 'hadoop-cluster-on-docker'.
2. You can specify the fisrt parameter, such as 5.
3. This script just rebuild hadoop image with different conf/slaves file, which pecifies the name of all slave nodes


Step 3. start container
sudo ./start-container.sh 5

Note: you shuld use the same parameter as the Step 2

Step 4. run hadoop cluster 

do 5~6 like Section A
