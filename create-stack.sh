#!/bin/bash

# N-Tier Application Stack Creation Script
# Usage: ./create-stack.sh [demo|poc|rnd|devops] [key-name]
export AWS_ACCESS_KEY_ID=ACCESS-KEY
export AWS_SECRET_ACCESS_KEY=SECRET-ACCESS-KEY
export AWS_SESSION_TOKEN=
export AWS_DEFAULT_REGION=us-west-2

ENVIRONMENT=${1:-demo}
KEY_NAME=${2:-demo_key}
STACK_NAME="N-TIER-APP-${ENVIRONMENT}-$(date +%m%d)"

echo "Creating CloudFormation stack: $STACK_NAME"
echo "Environment: $ENVIRONMENT"
echo "Key Name: $KEY_NAME"

# Create the stack
aws cloudformation create-stack \
  --stack-name $STACK_NAME \
  --template-body file://n-tier-app.json \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameters ParameterKey=KeyName,ParameterValue=$KEY_NAME \
               ParameterKey=EnvName,ParameterValue=$ENVIRONMENT

if [ $? -eq 0 ]; then
    echo "Stack creation initiated successfully"
    echo $STACK_NAME > stack-id-${ENVIRONMENT}.txt
    ln -fs ./stack-id-${ENVIRONMENT}.txt stack-id.txt
    echo "Stack ID saved to stack-id-${ENVIRONMENT}.txt"
    echo "Symbolic link created: stack-id.txt -> stack-id-${ENVIRONMENT}.txt"
    
    echo "Monitoring stack creation..."
    aws cloudformation wait stack-create-complete --stack-name $STACK_NAME
    
    if [ $? -eq 0 ]; then
        echo "Stack created successfully!"
        echo "Getting stack outputs..."
        aws cloudformation describe-stacks --stack-name $STACK_NAME --query 'Stacks[0].Outputs'
    else
        echo "Stack creation failed or timed out"
        exit 1
    fi
else
    echo "Failed to initiate stack creation"
    exit 1
fi