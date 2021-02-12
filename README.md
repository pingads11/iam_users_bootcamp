# PURPOSE

This creates:

* 2 AWS IAM Groups: Trainers and Students.

* A set of users defined in the **variables.tf** file. You can add/remove/modify their names under the desired group.

* Attachments of the users to their respective groups.

* A set of policies defined in the **variables.tf** file. VPC, EC2, and CloudFormation Full Access, as well as custom S3 access without Delete actions have been assigned to the student group, and Administrator Access has been assigned to the trainers group.

_(Note that Full Access grants students the permission to manage all the resources in that category, including the ones that belong to other users. As of now, there is no clear way to deny that action since all users are part of the same account. The only solution is to insist on creating tags with their names and avoid touching resources tagged by other users.)_

* Attachments of the policies to their respective groups.

* A private S3 Bucket used as remote backend for Terraform with a DynamoDB state lock.

# HOW-TO DEPLOY

1) Configure **aws-cli** with your access keys.

2) Clone this repository locally.

3) Run **terraform init** and **terraform apply** the first time.

4) Verify the successful deployment: Groups, Users, Permissions, and S3 Bucket.

5) Go to the **main.tf** file and uncomment the first block named **REMOTE S3 BACKEND**.

6) Run **terraform init AND terraform apply** a second time to change the **terraform.tfstate** file storage from local to remote.

7) Verify that the S3 Bucket contains the state file.

