/*   Main execution file, usually it has providers configuration */
  
provider "aws" {
  region  = "eu-west-1"
  access_key = var.key_access
  secret_key = var.key_secret
  //profile = "default"
}
resource "aws_s3_bucket" "b" {
  bucket = "mapfre-gitops-mmjesu6"

  tags = {
    Name        = "mmjesu6@mapfre.com"
    Owner = "mmjesu6@mapfre.com"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "public-read"
}
resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.b.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
  /*
  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
  */
}
resource "aws_s3_object" "object" {

  bucket = aws_s3_bucket.b.id
  key    = "index.html"
  acl    = "public-read"  # or can be "public-read"
  source = "index.html"
  etag = filemd5("index.html")
  content_type = "text/html"

}
      