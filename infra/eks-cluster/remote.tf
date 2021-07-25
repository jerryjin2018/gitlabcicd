#config S3 as the terraform remote backend, so terraform will save/retrieve states fiel in S3 bucket

terraform {
  backend "s3" {
    bucket  = "jerry-terraform-states"
    key     = "terrafeks.tfstate"
    region  = "cn-northwest-1"
    encrypt = true
  }
}
