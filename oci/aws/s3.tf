resource "aws_s3_bucket" "backup_s3_bucket" {
  bucket = var.s3_bucket_name
}

resource "aws_s3_bucket_policy" "backup_s3_bucket" {
  bucket = aws_s3_bucket.backup_s3_bucket.bucket

  policy = jsonencode(
    {
      Version = "2012-10-17"
      Id      = "HTTPSOnly"
      Statement = [
        {
          Sid       = "HTTPSOnly"
          Effect    = "Deny"
          Principal = "*"
          Action    = "s3:*"
          Resource = [
            aws_s3_bucket.backup_s3_bucket.arn,
            "${aws_s3_bucket.backup_s3_bucket.arn}/*",
          ]
          Condition = {
            Bool = {
              "aws:SecureTransport" = "false"
            }
          }
        },
      ]
    }
  )
}

resource "aws_s3_bucket_public_access_block" "backup_s3_bucket" {
  bucket = aws_s3_bucket.backup_s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
