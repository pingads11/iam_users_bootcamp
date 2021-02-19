# PURPOSE

This creates:

* 2 AWS IAM Groups: Trainers and Students.

* A set of users defined in the **variables.tf** file. You can add/remove/modify their names under the desired group.

* Attachments of the users to their respective groups.

* A set of policies defined in the **variables.tf** file. VPC, EC2, and CloudFormation Full Access, as well as custom S3 access without Delete actions have been assigned to the student group, and Administrator Access has been assigned to the trainers group.

_(Note that Full Access grants students the permission to manage all the resources in that category, including the ones that belong to other users. As of now, there is no clear way to deny that action since all users are part of the same account. The only solution is to insist on creating tags with their names and avoid touching resources tagged by other users.)_

* Attachments of the policies to their respective groups.

* A private S3 Bucket used as remote backend for Terraform with a DynamoDB state lock.


# REQUIREMENTS

* The student users need to be able to reset their passwords after the first login. To do that, they need permission from the AWS Account that deploys them. Go to IAM -> Account Settings on the left panel -> Change password policy -> **Allow users to reset their passwords** (Make sure you check any other field that was applied in the previous configuration)


# HOW-TO DEPLOY

1) Configure **aws-cli** with your access keys.

2) Create a Keybase account with a PGP key - no need to install it locally.

3) Clone this repository locally.

4) Open **main.tf** and check the very first block named **REMOTE S3 BACKEND**; it should all be commented out. _This is to make sure that you first deploy everything  correctly with a local state file._

5) Still in **main.tf**, go to the last **four** resources below the **IAM User Access Keys** block and update the **pgp_key** arguments - it should be "keybase:yourusername" in **all of them**.

6) Run **terraform init** and **terraform apply** the first time.

7) Verify the successful deployment: Groups, Users, Permissions, and S3 Bucket.

8) Now, go to **main.tf** and uncomment the first block named **REMOTE S3 BACKEND**.

9) Run **terraform init** _(and terraform plan/apply if you want to check for changes)_ a second time to change the **terraform.tfstate** file storage from local to remote.

10) Verify that the S3 Bucket contains the state file.

11) To enable users access to the AWS Console:

* Running Terraform Apply outputs Student Access Key IDs, Student Access Key Secrets, Encrypted Student Passwords, Student Users, Trainer Access Key IDs, Trainer Access Key Secrets, Encrypted Trainer Passwords, Trainer Users in this other. 

* For now, the manual part of this automation is to decrypt each password and communicate it to its user. The decryption can be done on _https://keybase.io/decrypt_ with the same profile whose usernamed was applied to the **pgp_key** arguments, but you need to paste the encrypted password in the **keybase_pgp_template** file provided for the correct format.

* Encrypted passwords can be seen on the state file as expected, but the only person able to decrypt them is the one with the Keybase account.

* Access Key Secrets are visible on the remote backend state file, unencrypted. Encryption can be added by uncommenting the **pgp_key** argument in the **two** **aws_iam_access_key** resources. This adds more manual work.

_(A less manual option can be investigated using the Keybase desktop app or pkg. Note that it cannot be used with root privilege.)_

# TERRAFORM DESTROY

**NEVER DELETE THE BUCKET MANUALLY FIRST**

1) In **main.tf**, comment out the first remote S3 backend block and run **terraform init** to save the state file locally.

2) Go to the S3 bucket block and comment out the **lifecycle** block

3) Then uncomment **force_destroy = true**

4) Finally, run **terraform destroy**.

5) Due to the versioning of the bucket, it might destroy everything except the bucket and its contents. In that case, manually use the **empty** action on the bucket then **delete** it.

6) Run **terraform apply** after to account for that.

