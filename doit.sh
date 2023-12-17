#!/bin/bash
aws cloudformation create-stack --stack-name N-TIER-APP-022 \
--template-body file:///home/aws/Projects/cloudFormation/n-tier-app/n-tier-app.json \
--capabilities CAPABILITY_NAMED_IAM