# bastion
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow traffic for the bastion server"
  vpc_id      = aws_vpc.raku_vpc.id

  tags = {
    Name = "bastion_sg"
  }
}

resource "aws_security_group_rule" "bastion_allow_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "bastion_allow_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion_sg.id
}

#EKS Cluster
 resource "aws_security_group" "cluster_sg" {
   name        = "cluster-sg"
   description = "Allow traffic for a cluster"
   vpc_id      = aws_vpc.raku_vpc.id

   tags = {
     Name = "cluster_sg"
   }
 }

 resource "aws_security_group_rule" "cluster_allow_ingress_from_bastion" {
   type                     = "ingress"
   from_port                = 0
   to_port                  = 65535
   protocol                 = "tcp"
   source_security_group_id = aws_security_group.bastion_sg.id
   security_group_id        = aws_security_group.cluster_sg.id
    }

 resource "aws_security_group_rule" "cluster_allow_egress_cluster" {
   type              = "egress"
   from_port         = 0
   to_port           = 65535
   protocol          = "tcp"
   cidr_blocks       = ["0.0.0.0/0"]
   security_group_id = aws_security_group.bastion_sg.id
 }

#Node Group
 resource "aws_security_group" "node_grp_sg" {
   name        = "node-grp-sg"
   description = "Allow traffic for a node group"
   vpc_id      = aws_vpc.raku_vpc.id

   tags = {
     Name = "node_grp_sg"
   }
 }

 resource "aws_security_group_rule" "allow_ingress_from_cluster" {
   type                     = "ingress"
   from_port                = 0
   to_port                  = 65535
  protocol                 = "tcp"
   source_security_group_id = aws_security_group.cluster_sg.id
   security_group_id        = aws_security_group.node_grp_sg.id
   }

 resource "aws_security_group_rule" "allow_egress_node_group" {
   type              = "egress"
   from_port         = 0
   to_port           = 65535
   protocol          = "tcp"
   cidr_blocks       = ["0.0.0.0/0"]
   security_group_id = aws_security_group.node_grp_sg.id
 }



#db-redis 6379 6380
resource "aws_security_group" "redis_sg" {
  name        = "redis-sg"
  description = "Allow traffic for the redis server"
  vpc_id      = aws_vpc.raku_vpc.id

  tags = {
    Name = "redis_sg"
  }
}

resource "aws_security_group_rule" "redis_allow_ingress" {
  type              = "ingress"
  from_port         = 6379
  to_port           = 6380
  protocol          = "tcp"
  cidr_blocks       = ["10.0.0.0/16"]
  security_group_id = aws_security_group.redis_sg.id
}

resource "aws_security_group_rule" "redis_allow_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.redis_sg.id
}

/*

#db-mysql
resource "aws_security_group" "mysql_sg" {
  name        = "mysql-sg"
  description = "Allow traffic for the db server"
  vpc_id      = aws_vpc.raku_vpc.id

  tags = {
    Name = "mysql_sg"
  }
}

resource "aws_security_group_rule" "mysql_allow_ingress" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mysql_sg.id
}

resource "aws_security_group_rule" "mysql_allow_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.mysql_sg.id
}


# alb
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Allow traffic for the alb server"
  vpc_id      = aws_vpc.raku_vpc.id

  tags = {
    Name = "alb_sg"
  }
}

resource "aws_security_group_rule" "allow_traffic" {
  type              = "ingress"
  from_port         = 50051
  to_port           = 50051
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.tracker_sg.id
}

resource "aws_security_group_rule" "allow_egress_alb" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_sg.id
}

*/