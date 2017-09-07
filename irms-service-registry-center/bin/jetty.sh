#!/bin/bash
#docker_qc
BASE_HOME="/home/irms-service-registry-center/sources"
#qc
#BASE_HOME="/home/dockerfile/irms-service-registry-center/sources"


cd $BASE_HOME
work=$1
now=$(date +%Y%m%d)
log_file_url="service-registry-center_${now}.log"
APP_START_DT=`date +"%Y%m%d"`
APP_JAR_LOCAL="irms-service-registry-center-0.0.1.jar"
APP_JAR=`ls irms-service-registry-center-0.0.1.jar`
JAVA_CMD="/usr/bin/java"

JAVA_OPTS=" -server \
-Xms1024m -Xmx1024m  \
-XX:PermSize=128M \
-XX:MaxPermSize=256m \
-Xss2m \
-Xmn512m \
-XX:+AggressiveOpts \
-XX:+UseBiasedLocking \
-XX:+CMSParallelRemarkEnabled \
-XX:+UseConcMarkSweepGC \
-XX:ParallelGCThreads=2 \
-XX:SurvivorRatio=2 "

JAVA_OPTIONS=$JAVA_OPTS

JETTY_PID="/data/logs/jetty.pid"


status() {
	 test -n   "`ps -ef |grep "$APP_JAR" |grep -v grep `"  && echo 1  || echo 0
}

start() {
	if [ "`status`" == "1"  ] ; then
		echo "app jetty is woring,do nothing!"
		exit 1
	fi
	$JAVA_CMD   $JAVA_OPTS -Dloader.path="lib/*" -jar   $BASE_HOME/$APP_JAR_LOCAL --spring.profiles.active=$SPRING_ACTIVE --spring.config.location=file:../config/ >> /data/irms-log/service-registry-center/"$log_file_url"  2>&1
        echo "started $APP_JAR"
}

stop() {
	pid=` ps -ef |grep java | grep "$BASE_HOME/$APP_JAR" |awk '{print $2}'`
	if [ -n "$pid"  ] ; then
		kill -9 $pid
	fi
	echo "stoped $APP_JAR"
}


case "$work" in
	"start" ) 
		start ;
		exit 1;
		;;
	"status")
		echo `status`;
		exit 1;
		;;
	"stop" )
		stop;
		exit 1;
		;;
	"restart" )
		stop 
		sleep 5
		start;
		exit 1
		;;
	* ) 
		echo "unknow command !"
		exit 1;
		;;
esac

