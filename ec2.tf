resource "aws_instance" "fabi-devops" {
    count = 2
    ami = "ami-0b6c2d49148000cd5"
    instance_type = "t2.micro"
    key_name = "terraform-devops"

    vpc_security_group_ids = ["adicionar-sg"]

    tags = {
      Name = "ec2-atividade1terraform"
    }

provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
  
}

provisioner "remote-exec" {
    inline = [ 
        "sudo chmod +x /tmp/script.sh",
        "sudo bash /tmp/script.sh",
        "sudo systemctl restart nginx",
    ]
}

connection {
  type = "ssh"
  user = "ubuntu"
  private_key = file("./terraform-devops.pem")
  host = self.public_ip
}

}