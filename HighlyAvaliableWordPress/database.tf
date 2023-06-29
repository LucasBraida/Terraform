resource "aws_security_group" "wp-db-SG" {
  name        = "wp-db-SG"
  vpc_id      = aws_vpc.wp-vpc.id
  description = "Allow 3306 trafic to the wordpress instance"
  ingress {
    description = "Allow Mysql Port"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.101.0/24"]
  }

  egress {
    description = "Allow outbound trafic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }



  tags = {
    "Name" = "wp-db-SG"
  }
}
# resource "aws_rds_cluster_instance" "wp-db-instance" {
#   identifier         = "wp-db-aurota-instance"
#   cluster_identifier = aws_rds_cluster.wp-db-cluster.id
#   instance_class     = "db.t3.small"
#   engine             = aws_rds_cluster.wp-db-cluster.engine
#   engine_version     = aws_rds_cluster.wp-db-cluster.engine_version
# }

# resource "aws_rds_cluster" "wp-db-cluster" {
#   cluster_identifier   = "wp-db-aurora-cluster"
#   engine               = "aurora-mysql"
#   db_subnet_group_name = module.wp-vpc-simple.database_subnet_group
#   database_name        = "wordpress"
#   master_username      = "wordpress"
#   master_password      = "wordpress"
# }

resource "aws_db_subnet_group" "database" {
  name = "database"
  subnet_ids = [for subnet in aws_subnet.database-subnet : subnet.id]
}
resource "aws_db_instance" "wp-db" {
  db_name                = "wpdb2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.small"
  allocated_storage      = 10
  username               = "wordpress"
  password               = "wordpress"
#   multi_az               = true
  db_subnet_group_name   = aws_db_subnet_group.database.name
  vpc_security_group_ids = [aws_security_group.wp-db-SG.id]
}