##################################
##### CREATING THE S3 BUCKET #####
##################################

resource "aws_s3_bucket" "tfstate_bucket" {

  bucket = var.bucket_name

  acl    = "private"

### The argument below prevents the bucket to be accidentally destroyed
### by "terraform destroy". This will avoid losing the terraform.tfstate file
### stored as backend in the S3 bucket. Comment it out if you want to
### destroy the bucket.

#  lifecycle {
#    prevent_destroy = true
#  }

### The argument below should be commented out by default. If you want to
### destroy the bucket, uncomment it. It will delete all the files
### inside it in an unrecoverable manner!

#  force_destroy = true

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

