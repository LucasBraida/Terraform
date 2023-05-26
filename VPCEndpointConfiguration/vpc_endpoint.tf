resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id          = aws_vpc.my-vpc.id
  service_name    = "com.amazonaws.us-east-1.s3"
  route_table_ids = [aws_route_table.public-RT.id]
}
