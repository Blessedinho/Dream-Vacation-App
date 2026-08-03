resource "tls_private_key" "dream_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "dream_key" {
  key_name   = "dream-key-tf"
  public_key = tls_private_key.dream_key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.dream_key.private_key_pem
  filename        = "${path.module}/dream-key-tf.pem"
  file_permission = "0400"
}
