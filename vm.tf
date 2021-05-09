# Define common EC2 the private subnet


resource "aws_instance" "app1" {
   ami  = var.ami
   instance_type = "t2.micro"
   key_name = aws_key_pair.deployer.id
   vpc_security_group_ids = [aws_security_group.public.id]
   associate_public_ip_address = true

   connection {
    type = "ssh"
    user        = "ubuntu"
    private_key = file("pri.pem")
    host = aws_instance.app1.public_ip
  }
   
   provisioner "file" {
    source      = "docker.sh"
    destination = "/tmp/docker.sh"
  }

  provisioner "file" {
    source      = "Dockerfile"
    destination = "/tmp/Dockerfile"
  }

   provisioner "remote-exec" {
    inline = [
      "bash /tmp/docker.sh",
      "git clone https://github.com/city-mall/react-express-app.git",
      "cp /tmp/Dockerfile react-express-app",
    ]
  } 
  
 provisioner "remote-exec" {
    inline = [
      "cd react-express-app",
      "docker image build -t city_mall .",
      "docker run -d -p 8080:8080 --name citymall city_mall",
    ]
  }

}


