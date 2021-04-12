#######################
##### BUCKET NAME #####
#######################

### If the name below is changed, make sure to change it also
### in the remote s3 backend block in the root main.tf

variable "bucket_name" {
  type = string
  default = "tfstate-bootcamp-bucket"
}

