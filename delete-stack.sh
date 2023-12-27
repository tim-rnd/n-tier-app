#!/bin/bash
export counter=`cat stack-id.txt`
counter=$(printf "%06d" $counter)
stack_id=N-TIER-APP-$counter
echo "Deleting stack $stack_id"
aws cloudformation delete-stack --stack-name N-TIER-APP-$counter
