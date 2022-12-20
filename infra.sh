#!/bin/bash

#Declaring Variables
LRED='\033[1;31m'
LGREEN='\033[1;32m'
NC='\033[0m'
AMI_ID="ami-02b972fec07f1e659"
SUBNET_IDS="subnet-06cb9704b11863a80"
TYPE="t3.micro"
KEY_PAIR="awsroxs"
SG_ID="sg-0ae1443dda2c5a3ec"
EC2_NAME="AWSEC2Shell"
USERDATA="userdata.txt"
COUNT=1

echo -e "\n${LGREEN}checking connection${NC}"

if
        aws ec2 describe-vpcs >/dev/null 2>&1; then
  echo -e "\n${LGREEN}Test connection to AWS was successful.${NC}";
else
  echo -e "\n${LRED}ERROR: test connection to AWS failed. Please check the AWS keys.${NC}";
  exit 1;
fi

#Create EC2 instance
function create_ec2(){
    echo "Creating EC2 instances"
    for ((i=0; i < $COUNT; i++))
        do
        echo "Creating EC2 instance ${EC2_NAME[$i]}"
        aws ec2 run-instances --image-id $AMI_ID \
        --count 1 --instance-type $TYPE --key-name $KEY_PAIR \
        --security-group-ids $SG_ID --subnet-id ${SUBNET_IDS} \
        --user-data file://${USERDATA} \
        --associate-public-ip-address \
        --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value="'"${EC2_NAME[$i]}"'"}]' \
        --output text >  /dev/null 2>&1 
        echo -e "\n${LGREEN} instance ${EC2_NAME[$i]} created${NC}"
        done 
    echo -e "\n${LGREEN}EC2 instance creation complete${NC}"
}

create_ec2
