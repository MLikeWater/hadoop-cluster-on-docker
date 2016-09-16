FROM ubuntu:16.04

MAINTAINER jiangshouzhuang <jiangshouzhuang@163.com>

# Install Oracle JDK
RUN mkdir -p /usr/lib/jvm
ADD jdk-7u80-linux-x64.tar.gz /usr/lib/jvm/
RUN ln -s /usr/lib/jvm/jdk1.7.0_80 /usr/lib/jvm/default
ENV JAVA_HOME /usr/lib/jvm/default
ENV JRE_HOME $JAVA_HOME/jre 
ENV PATH $JAVA_HOME/bin:$PATH
ENV CLASSPATH .:$JAVA_HOME/lib:$JRE_HOME/lib

RUN rm -f /usr/bin/java
RUN ln -s /usr/lib/jvm/default/bin/java /usr/bin/java

# Install hadoop 2.7.3
ADD hadoop-2.7.3.tar.gz /usr/local
RUN ln -s /usr/local/hadoop-2.7.3 /usr/local/hadoop
ENV HADOOP_HOME /usr/local/hadoop
ENV PATH $HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH

# ssh without key
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

RUN mkdir -p /hadoopdata/dfs/namenode && \ 
    mkdir -p /hadoopdata/dfs/datanode && \
    mkdir $HADOOP_HOME/logs

COPY config/* /tmp/

RUN mv /tmp/ssh_config ~/.ssh/config && \
    mv /tmp/hadoop-env.sh $HADOOP_HOME/hadoop/etc/hadoop/hadoop-env.sh && \
    mv /tmp/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml && \ 
    mv /tmp/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml && \
    mv /tmp/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml && \
    mv /tmp/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml && \
    mv /tmp/slaves $HADOOP_HOME/etc/hadoop/slaves && \
    mv /tmp/start-hadoop.sh ~/start-hadoop.sh && \
    mv /tmp/run-wordcount.sh ~/run-wordcount.sh

RUN chmod +x ~/start-hadoop.sh && \
    chmod +x ~/run-wordcount.sh && \
    chmod +x $HADOOP_HOME/sbin/start-dfs.sh && \
    chmod +x $HADOOP_HOME/sbin/start-yarn.sh 

# format namenode
RUN /usr/local/hadoop/bin/hdfs namenode -format

CMD [ "sh", "-c", "service ssh start; bash"]

