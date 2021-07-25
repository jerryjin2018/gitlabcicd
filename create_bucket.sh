#! /bin/bash
. /etc/profile
. ~/.bashrc

Bucket_Name=jerry-terraform-states
FILEEKS=terrafeks.tfstate
FILERDS=terrafrds.tfstate

# Check if bucket is existing
aws s3api head-bucket --bucket $Bucket_Name 2>&1 | grep -q 404
EXIT_STATUS=$?

if [ "$EXIT_STATUS" -eq "0" ]; then

    # Bucket is not existing, create it and enable the versioning
    echo "$Bucket_Name is not existing."
    aws s3 mb s3://$Bucket_Name/
    aws s3api put-bucket-versioning --bucket $Bucket_Name --versioning-configuration Status=Enabled

    # Create object(Terraform state file) for EKS terraform file
    if [ -f "$FILEEKS" ]; then
        echo "$FILEEKS exists."
    else 
        echo "$FILEEKS does not exist."
        touch $FILEEKS
        aws s3 cp $FILEEKS s3://$Bucket_Name/$FILEEKS
        rm -f $FILEEKS
    fi

    # Create object(Terraform state file) for RDS terraform file
    if [ -f "$FILERDS" ]; then
        echo "$FILERDS exists."
    else 
        echo "$FILERDS does not exist."
        touch $FILERDS
        aws s3 cp $FILERDS s3://$Bucket_Name/$FILERDS
        rm -f $FILERDS
    fi
else
    # Bucket is existing
    echo "$Bucket_Name is existing."
fi  
