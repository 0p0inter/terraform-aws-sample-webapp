module "aws-rds" {
    #source                             = "./modules/terraform-aws-rds-mysql"
    source                              = "0p0inter/rds-mysql/aws"
    version                             = "1.0.0"
    #source                              = "github.com/0p0inter/terraform-aws-rds-mysql"
    database_identifier                 = var.rds_database_identifier
    allocated_storage                   = var.rds_allocated_storage
    engine_version                      = var.rds_engine_version
    rds_instance_class                  = var.rds_instance_class
    db_name                             = var.database_name
    username                            = "${random_string.random.result}"
    password                            = "${random_password.password.result}"
    rds_instance_parameter_group_name   = var.rds_instance_parameter_group_name
    vpc_security_group_ids              = [aws_security_group.rds_instance.id]
    subnet_ids                          = aws_subnet.private.*.id
    depends_on = [
        aws_vpc.main,
        aws_subnet.private
    ]
}