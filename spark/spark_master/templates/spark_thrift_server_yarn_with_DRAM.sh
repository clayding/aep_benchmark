
source ./scripts/tool.conf
echo "SPARK_HOME:$SPARK_HOME"
THRIFTSERVER_START_CMD="${SPARK_HOME}/sbin/start-thriftserver.sh"
THRIFTSERVER_STOP_CMD="${SPARK_HOME}/sbin/stop-thriftserver.sh"

THRIFTSERVER_CONFIG="--num-executors 2 \
	--driver-memory 10g \
	--executor-memory 60g \
	--executor-cores 10 \
	--master yarn \
	--deploy-mode client \
	--conf spark.speculation=false \
	--conf spark.kryoserializer.buffer.max=256m \
	--conf spark.kryoserializer.buffer=64m \
	--conf spark.sql.oap.rowgroup.size=972800 \
	--conf spark.yarn.numa.enabled=true \
	--conf spark.sql.oap.parquet.data.cache.enable=true \
	--conf spark.sql.oap.fiberCache.memory.manager=offheap \
	--conf spark.oap.cache.strategy=guava \
    --conf spark.memory.offHeap.enabled=false \
    --conf spark.sql.oap.fiberCache.offheap.memory.size=50g \
	--conf spark.sql.inMemoryColumnarStorage.compressed=true \
	--conf spark.sql.autoBroadcastJoinThreshold=31457280 \
	--conf spark.sql.broadcastTimeout=3600 \
	--conf spark.sql.shuffle.partitions=50"


start(){
  $THRIFTSERVER_START_CMD $THRIFTSERVER_CONFIG
}

stop(){
  $THRIFTSERVER_STOP_CMD $THRIFTSERVER_CONFIG
}

if [ "$1" == "stop" ] ; then
   stop
else
   if [ "$1" == "start" ] ; then
   start
   fi
fi
