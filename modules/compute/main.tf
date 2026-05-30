# Public VM with WordPress Remote Provisioner
resource "aws_instance" "public_ec2" {
  ami                   = data.aws_ami.ubuntu.id
  instance_type         = var.instance_type
  subnet_id             = var.public_subnet_id
  vpc_security_group_id = [aws_security_group.public_sg.id]
  key_name              = aws_key_pair.deployer_key.key_name
  iam_instance_profile  = data.aws_iam_instance_profile.existing_profile.name

  tags = { Name = "${var.target_env}-public-ec2" }

  # Connection block tells the provisioner how to SSH into the box
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = tls_private_key.vm_key.private_key_openssh
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "${path.module}/install_wordpress.sh"
    destination = "/tmp/install_wordpress.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install_wordpress.sh",
      "/tmp/install_wordpress.sh"
    ]
  }
}