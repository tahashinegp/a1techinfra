data "aws_ami" "ubuntu" {
   most_recent = "true"

   filter {
      name = "name"
      values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
   }

   filter {
      name = "virtualization-type"
      values = ["hvm"]
   }

   owners = ["amazon"]
}

resource "aws_instance" "web_server" {
   ami = data.aws_ami.ubuntu.id
   subnet_id      = var.public_subnet
   instance_type = "t2.micro"
   security_groups  = ["${element(split(",", var.security_group), 0)}"]
   //security_groups  = var.security_group[0]
   //key_name = aws_key_pair.aws_kp.key_name   ["${var.security_groups}"]
   //user_data = "${file("${path.module}/install_server.sh")}"

   tags =var.tags
}

