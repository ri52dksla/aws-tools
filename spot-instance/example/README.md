# example

```bash
mkdir .ssh
ssh-keygen -t rsa -b 4096 -f ./.ssh/id_rsa -q -N ""
```

```bash
terraform init .
export TF_VAR_ssh_public_key=$(cat .ssh/id_rsa.pub)
terraform plan .
terraform apply .
```

```bash
export LAUNCH_TEMPLATE_ID=$(terraform output launch_template_id)
export LAUNCH_TEMPLATE_VERSION=$(terraform output launch_template_latest_version)
export SUBNET_ID=$(terraform output public_subnet_id)
export INSTANCE_TYPE=m5.large

export LAUNCHED_INSTANCE_ID=$(aws ec2 run-instances \
--launch-template LaunchTemplateId=${LAUNCH_TEMPLATE_ID},Version=${LAUNCH_TEMPLATE_VERSION} \
--subnet-id ${SUBNET_ID} \
--instance-type ${INSTANCE_TYPE} --query 'Instances[0].InstanceId' --output text)

export LAUNCHED_INSTANCE=$(aws ec2 describe-instances --instance-ids ${LAUNCHED_INSTANCE_ID} --query 'Reservations[0].Instances[0]' )
export INSTANCE_ID=$(echo $LAUNCHED_INSTANCE | jq -r '.InstanceId')
export NETWORK_INTERFACE_ID=$(echo $LAUNCHED_INSTANCE | jq -r '.NetworkInterfaces[0].NetworkInterfaceId')
export PUBLIC_DNS_NAME=$(echo $LAUNCHED_INSTANCE | jq -r '.PublicDnsName')
ssh -i .ssh/id_rsa ubuntu@$PUBLIC_DNS_NAME

aws ec2 terminate-instances --instance-ids ${INSTANCE_ID}
aws ec2 delete-network-interface --network-interface-id ${NETWORK_INTERFACE_ID}
```
