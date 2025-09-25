locals {
  common_tags = {
    project = "vpc-peering"
    team    = "DevOps"
  }
}

resource "aws_vpc" "us_east_vpc" {
  cidr_block = "10.1.0.0/16"

  tags = merge(local.common_tags, {
    Name = "VPC-1"
  })
}

resource "aws_vpc" "us_west_vpc" {
  cidr_block = "172.16.0.0/16"
  provider   = aws.us-west

  tags = merge(local.common_tags, {
    Name = "VPC-2"
  })

}


resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_owner_id = var.peer_owner_id
  peer_vpc_id   = aws_vpc.us_west_vpc.id
  vpc_id        = aws_vpc.us_east_vpc.id
  peer_region   = "us-east-1"
  auto_accept   = false

  tags = merge(local.common_tags, {
    Name = "VPC1-to-VPC2"
  })
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.us-west
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  auto_accept               = true

  tags = merge(local.common_tags, {
    Side = "Accepter"
  })
}

