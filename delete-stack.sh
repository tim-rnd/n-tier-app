#!/bin/bash

# N-Tier Application Stack Deletion Script
# Usage: ./delete-stack.sh [environment]

ENVIRONMENT=${1:-demo}

if [ ! -f "stack-id-${ENVIRONMENT}.txt" ]; then
    echo "Stack ID file not found: stack-id-${ENVIRONMENT}.txt"
    echo "Available stack files:"
    ls -la stack-id-*.txt 2>/dev/null || echo "No stack ID files found"
    exit 1
fi

STACK_NAME=$(cat stack-id-${ENVIRONMENT}.txt)

echo "Deleting CloudFormation stack: $STACK_NAME"
echo "Environment: $ENVIRONMENT"

# Confirm deletion
read -p "Are you sure you want to delete stack $STACK_NAME? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Stack deletion cancelled"
    exit 0
fi

# Delete the stack
aws cloudformation delete-stack --stack-name $STACK_NAME

if [ $? -eq 0 ]; then
    echo "Stack deletion initiated successfully"
    echo "Monitoring stack deletion..."
    aws cloudformation wait stack-delete-complete --stack-name $STACK_NAME
    
    if [ $? -eq 0 ]; then
        echo "Stack deleted successfully!"
        rm -f stack-id-${ENVIRONMENT}.txt
        if [ -L stack-id.txt ] && [ "$(readlink stack-id.txt)" = "./stack-id-${ENVIRONMENT}.txt" ]; then
            rm -f stack-id.txt
            echo "Cleaned up stack ID files"
        fi
    else
        echo "Stack deletion failed or timed out"
        exit 1
    fi
else
    echo "Failed to initiate stack deletion"
    exit 1
fi