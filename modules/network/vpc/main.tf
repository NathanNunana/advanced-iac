resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "this" {
  for_each          = var.subnets
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  depends_on = [aws_vpc.this]
  tags = {
    Name = "${each.key}-subnet"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id     = aws_vpc.this.id
  depends_on = [aws_vpc.this]
  tags = {
    Name = var.igw
  }
}

resource "aws_route_table" "this" {
  vpc_id     = aws_vpc.this.id
  depends_on = [aws_vpc.this]
  route {
    cidr_block = var.rt_cidr
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = var.rt_name
  }
}

resource "aws_route_table_association" "this" {
  depends_on     = [aws_vpc.this, aws_subnet.this]
  route_table_id = aws_route_table.this.id
  subnet_id      = aws_subnet.this["public"].id
}
