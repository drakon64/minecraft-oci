resource "aws_s3_bucket" "backup_s3_bucket" {
  bucket = var.s3_bucket_name
}
