export JAVA_HOME={{ workplace }}/jdk1.8.0_161   
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:${JAVA_HOME}/lib/dt.jar:${JAVA_HOME}/lib/tools.jar:${JRE_HOME}/lib
export HADOOP_HOME={{ workplace }}/hadoop-2.7.5
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_YARN_HOME=${HADOOP_HOME}
export HADOOP_VERSION=2.7.5
export PATH=${JAVA_HOME}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:${HADOOP_HOME}/bin
