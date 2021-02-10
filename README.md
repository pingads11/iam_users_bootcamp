# HOW-TO

This creates:

* 2 AWS IAM Groups: Trainers and Students.

* A set of users defined in the **variables.tf** file. You can add/remove/modify their names under the desired group.

* Attachments of the users to their respective groups.

* A set of policies defined in the **variables.tf** file. VPC, EC2, and CloudFormation Full Access has been defined under both groups, and Administrator Access under the trainers only.

* Attachments of the policies to their respective groups.

