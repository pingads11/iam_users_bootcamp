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

2) Create a Keybase account with a PGP key - no need to install it locally.

3) Clone this repository locally.

4) Go to the last **2** resources under the **IAM User Login Profiles** block and update the attribute **pgp_key** - it should be "keybase:yourusername" in **both of them**

5) Run **terraform init** and **terraform apply** the first time.

6) Verify the successful deployment: Groups, Users, Permissions, and S3 Bucket.

7) Go to the **main.tf** file and uncomment the first block named **REMOTE S3 BACKEND**.

8) Run **terraform init AND terraform apply** a second time to change the **terraform.tfstate** file storage from local to remote.

9) Verify that the S3 Bucket contains the state file.

10) To enable users access to the AWS Console:

* Running Terraform Apply outputs Encrypted Student Passwords, Student Users, Encrypted Trainer Passwords, Trainer Users in this other. For now, the manual part of this automation is to decrypt each password and communicate it to its user. This can be done on _https://keybase.io/decrypt_, but you need to paste the encrypted password in the **keybase_pgp_template** file provided

* Encrypted passwords can be seen on the state file as expected, but the only person able to decrypt them is the one with the Keybase account.

_(A less manual option can be investigated using the Keybase desktop app or pkg. Note that it cannot be used with root privilege)_

# REQUIREMENTS

* The student users need to be able to reset their passwords after the first login. To do that, they need permission from the AWS Account that deploys them. Go to IAM -> Account Settings on the left panel -> Change password policy -> **Allow users to reset their passwords** (Make sure you check any other field was applied in the previous configuration)
