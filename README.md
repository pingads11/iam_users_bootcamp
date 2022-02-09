# PURPOSE

This creates:

* 2 AWS IAM Groups: Trainers and Students.

* A set of users defined in the **variables.tf** file. You can add/remove/modify their names under the desired group.

* Attachments of the users to their respective groups.

* A set of policies defined in the **variables.tf** file. VPC, EC2, and CloudFormation Full Access, as well as custom S3 access without Delete actions have been assigned to the student group, and Administrator Access has been assigned to the trainers group.

_(Note that Full Access grants students the permission to manage all the resources in that category, including the ones that belong to other users. As of now, there is no clear way to deny that action since all users are part of the same account. The only solution is to insist on creating tags with their names and avoid touching resources tagged by other users.)_

* Attachments of the policies to their respective groups.

* Two private S3 Buckets, one used as general storage for the bootcamp, and one used as a remote backend for Terraform with a DynamoDB state lock.


# REQUIREMENTS

* AWS CLI >= 2.1.9

* Terraform >= 0.14.5

* Keybase app >= 5.6.1

* If there are problems during decryption, check the **keybase_pgp_template** file and make sure the version is up to date with the encrypted pgp message **format** (not with the Keybase app version).


# HOW TO DEPLOY...

1. Configure **aws cli** with your access keys.

2. Create a Keybase account and a PGP key for it - [Keybase](https://www.keybase.io). You will also have to install its pkg locally so that automated decryption can be used - [Keybase App](https://www.keybase.io/download).

3. Clone this repository locally.

4. Open **main.tf** and check the very first block named **REMOTE S3 BACKEND**; it should all be commented out. _This is to make sure that you first deploy everything correctly with a local state file._ ---not needed(new)

5. Go to **variables.tf** - third block named **KEYBASE USERNAME**, and update the username with **yours**. --run keybase login and enter username and password of your keybase(new)

6. Run `terraform init` and `terraform apply` the first time.

7. Verify the successful deployment: Groups, Users, Permissions, and S3 Buckets.

_Steps 8, 9, and 10 are OPTIONAL (For the Remote Backend)_

8. Now, go to **main.tf** and uncomment the first block named **REMOTE S3 BACKEND**. --not needed(new)

9. Run `terraform init` _(and terraform plan/apply if you want to check for changes)_ a second time to change the **terraform.tfstate** file storage from local to remote. --not needed(new)

10. Verify that the **restricted** S3 Bucket contains the state file.--not needed(new)

11. To enable users access to the AWS Console:

* Make sure your present working directory is **bootcamp-iam**, then run the shell script `./credentials.sh`.

* After some time processing `terraform output`, you will be prompted for your **Keybase** password.

* Passwords and secrets are decrypted, and a global credentials file named **all_credentials.txt** will be available under the **bootcamp-iam/** directory.

* For extra safety, the **all_credentials.txt** file is in **.gitignore**, and the contents of the **credentials/{raw,clean,decrypted}** directories are wiped after producing **all_credentials.txt**.


# ...HOW TO DESTROY

**NEVER DELETE THE REMOTE BACKEND BUCKET MANUALLY FIRST!**

1. _[If the remote backend is enabled]_ In **main.tf**, comment out the first remote S3 backend block and run `terraform init` to save the state file locally.

2. Go to the S3 bucket block and comment out the **lifecycle** block

3. Then uncomment **force_destroy = true**

4. Finally, run `terraform destroy`.

5. Due to the versioning of the bucket, it might destroy everything except the bucket and its contents. In that case, manually use the **empty** action on the bucket then **delete** it.

6. Run `terraform apply` after to account for that.

