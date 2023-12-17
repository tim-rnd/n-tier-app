#!/bin/bash
export counter=`cat stack-id.txt`
counter=$((counter + 1))
echo $counter  > stack-id.txt
counter=$(printf "%06d" $counter)
stack_id=N-TIER-APP-$counter
echo "Creating stack $stack_id:"
aws cloudformation create-stack --stack-name N-TIER-APP-$counter \
--template-body file:///home/aws/Projects/cloudFormation/n-tier-app/n-tier-app.json \
--capabilities CAPABILITY_NAMED_IAM

