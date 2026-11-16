resource "aws_s3_bucket" "bucket1" {
  # to create one bucket
  # bucket = "my-unique-bucket-name-12345" 
  # to createt multiple buckets

  # using list, count
    count=length(var.bucket_names)
    bucket=var.bucket_names[count.index]
    tags = var.tags
}
resource "aws_s3_bucket" "bucket2" {

  # using set, for_each
    for_each=var.bucket_names_set
    bucket=each.value
    tags = var.tags
    depends_on = [ aws_s3_bucket.bucket1 ] # only create bucket2 after bucket1 is created
}