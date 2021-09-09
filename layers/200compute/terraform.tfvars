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
key_name      = "XXXXXXXXXXXXXX" ### PLEASE UPDATE TO YOUR KEY PAIR
user_data     = <<EOF
#!/bin/bash
yum update -y
EOF
