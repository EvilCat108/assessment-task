#!/bin/bash

#Create S3 for remote backend
aws s3api create-bucket --bucket eks-atlantis-bucket --region eu-west-1 --create-bucket-configuration LocationConstraint=eu-west-1

#Terraform part
cd ./eks-terraform
terraform init
terraform apply -auto-approve
mkdir ~/.kube/
terraform output kubeconfig>~/.kube/config
terraform output config_map_aws_auth > configmap.yml
kubectl apply -f configmap.yml

#Helm part
helm install atlantis stable/atlantis -f values.yaml
