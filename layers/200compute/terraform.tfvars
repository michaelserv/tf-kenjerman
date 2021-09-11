###############################################################################
# Environment
###############################################################################
aws_account_id = "XXXXXXXXXXXXXX" ### PLEASE UPDATE THE AWS ACCOUNT NUMBER
environment    = "Development"   ### PLEASE UPDATE YOUR ENVIRONMENT IF NEEDED
region         = "XXXXXXXXXXXXXX" ### PLEASE UPDATE THE AWS REGION

###############################################################################
# Bastion
###############################################################################
instance_type = "t3.micro"
key_name      = "antonio-rackspace" ### PLEASE UPDATE TO YOUR KEY PAIR
user_data     = <<EOF
#!/bin/bash
yum update -y
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
kubectl version --short --client
EOF

###############################################################################
# EKS Worker Nodes
###############################################################################
eks_cluster_version               = "1.20"
worker_nodes_name                 = "worker-group-eks"
worker_nodes_instance_type        = "t3a.medium"
worker_nodes_asg_desired_capacity = 1
