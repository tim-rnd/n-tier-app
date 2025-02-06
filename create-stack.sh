#!/bin/bash
# to configure per account
# 1. run ls -sf stack-id-<account>.txt stack-id.txt
# 2. edit create-stack.sh change parameterKey/Value to approperiate key name
[ ! -z $1 ] && PROFILE=${1,,} || PROFILE="default"
export counter=`cat stack-id.txt`
counter=$((counter + 1))
echo $counter  > stack-id.txt
counter=$(printf "%06d" $counter)
stack_id=N-TIER-APP-$counter
echo "Creating stack $stack_id: $PROFILE"
# KeyName:= demo_key | sandbx_key | poc_key
aws cloudformation create-stack --stack-name N-TIER-APP-$counter \
--template-body file:///home/aws/projects/cloudFormation/n-tier-app/n-tier-app.json \
--capabilities CAPABILITY_NAMED_IAM \
--parameters ParameterKey=KeyName,ParameterValue=n-tier-key \
--profile $PROFILE

