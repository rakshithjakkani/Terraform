
/**
 * VPC
 */

resource "aws_vpc" "main" {
  cidr_block           = "${var.cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags {
    Name        = "${var.name}"
    Environment = "${var.environment}"
    Terraform   =  "true"
  }
}

/**
 * Gateways
 */

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name        = "${var.name}"
    Environment = "${var.environment}"
    Terraform   =  "true"
  }
}

/**
 * Subnets.
 */

resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${element(split("|", element(var.public_subnets_block_1, count.index)), 0)}"
  availability_zone       = "${element(split("|", element(var.public_subnets_block_1, count.index)), 1)}"
  count                   = "${length(var.public_subnets_block_1)}"
  map_public_ip_on_launch = true

  tags {
    Name             = "${var.name}-public-${element(split("|", element(var.public_subnets_block_1, count.index)), 2)}"
    Environment      = "${var.environment}"
    Terraform        = "true"
    AvailabilityZone = "${element(split("|", element(var.public_subnets_block_1, count.index)), 1)}"
  }
}

resource "aws_subnet" "public_block_2" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${element(split("|", element(var.public_subnets_block_2, count.index)), 0)}"
  availability_zone       = "${element(split("|", element(var.public_subnets_block_2, count.index)), 1)}"
  count                   = "${length(var.public_subnets_block_2)}"
  map_public_ip_on_launch = true

  tags {
    Name             = "${var.name}-public-${element(split("|", element(var.public_subnets_block_2, count.index)), 2)}"
    Environment      = "${var.environment}"
    Terraform        = "true"
    AvailabilityZone = "${element(split("|", element(var.public_subnets_block_2, count.index)), 1)}"
  }
}
resource "aws_subnet" "private" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${element(split("|", element(var.private_subnet_block_1, count.index)), 0)}"
  availability_zone       = "${element(split("|", element(var.private_subnet_block_1, count.index)), 1)}"
  count                   = "${length(var.private_subnet_block_1)}"

  tags {
    Name             = "${var.name}-private-${element(split("|", element(var.private_subnet_block_1, count.index)), 2)}"
    Environment      = "${var.environment}"
    Terraform        = "true"
    AvailabilityZone = "${element(split("|", element(var.private_subnet_block_1, count.index)), 1)}"
  }
}

/**
 * NAT Gateway
 */

resource "aws_eip" "nat_eip_1" {

  vpc = true

  lifecycle {
    create_before_destroy = true
  }

}

data "aws_subnet" "nat_subnet_id" {
  availability_zone = "${element(split("|", var.nat_az_and_subnet_name), 0)}"

  tags = {
    Name = "${var.name}-public-${element(split("|",var.nat_az_and_subnet_name), 1)}"
  }

  #depends_on = ["aws_subnet.public"]
}


# NAT Gateway kept in the same subnet as the ALB since ALB subnet is sized at 254
resource "aws_nat_gateway" "nat" {

  allocation_id = "${aws_eip.nat_eip_1.id}"
  subnet_id     = "${data.aws_subnet.nat_subnet_id.id}"

  lifecycle {
    create_before_destroy = true
  }

  tags {
    Name        = "fynd-infra-nat-gateway-az-a"
    Environment = "${var.environment}"
    Service     = "nat"
    Domain      = "infra"
  }
}

/**
 * Route tables
 */

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.name}-public-001"
    Environment = "${var.environment}"
    Terraform   =  "true"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.name}-private-001"
    Environment = "${var.environment}"
    Terraform   =  "true"
  }
}

/**
 * Routes
 */

resource "aws_route" "public" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
}

resource "aws_route" "private" {
  route_table_id         = "${aws_route_table.private.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat.id}"
}

/**
 * Route associations
 */

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets_block_1)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "public_rta_2" {
  count          = "${length(var.public_subnets_block_2)}"
  subnet_id      = "${element(aws_subnet.public_block_2.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
  count          = "${length(var.private_subnet_block_1)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}
