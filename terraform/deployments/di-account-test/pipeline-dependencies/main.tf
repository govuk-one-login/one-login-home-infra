resource "aws_s3_object" "file" {
  bucket = aws_s3_bucket.bucket.id
  key    = "platform-dns-certs/template.yaml"
  source = "/Users/fahmida.ahad/Documents/Repos/one-login-home-infra/platform-dns-certs/template.yaml"
}