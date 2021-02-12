# PURPOSE

This creates:

* 2 AWS IAM Groups: Trainers and Students.

* A set of users defined in the **variables.tf** file. You can add/remove/modify their names under the desired group.

* Attachments of the users to their respective groups.

* A set of policies defined in the **variables.tf** file. VPC, EC2, and CloudFormation Full Access, as well as custom S3 access without Delete actions have been defined under the student group, and Administrator Access under the trainers group.

* Attachments of the policies to their respective groups.

* A private S3 Bucket used as remote backend for Terraform with a DynamoDB state lock.

# HOW-TO DEPLOY

1) Run **terraform init** and **terraform apply** the first time.

2) Verify the successful deployment: Groups, Users, Permissions, and S3 Bucket.

3) Go to the **main.tf** file and uncomment the first block named **REMOTE S3 BACKEND**.

4) Run **terraform init AND terraform apply** a second time to change the **terraform.tfstate** file storage from local to remote.

5) Verify that the S3 Bucket contains the state file.

