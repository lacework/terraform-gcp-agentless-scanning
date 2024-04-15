JOB_NAME=$1
REGION=$2

for i in {1..5}
do
   if gcloud run jobs list --filter "metadata.name:${JOB_NAME} AND status.conditions[0].type:Ready AND status.conditions[0].status:True" --region ${REGION} | grep ${JOB_NAME}
   then
       echo "Cloud run job ${JOB_NAME} ready, executing now"
       gcloud run jobs execute ${JOB_NAME} --region=${REGION}
       exit
   else
       echo "Cloud run job ${JOB_NAME} not ready yet"
       sleep 10
   fi
done

echo "Cloud run job ${JOB_NAME} not ready after multiple attempts"
