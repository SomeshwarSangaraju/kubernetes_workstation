resource "aws_instance" "roboshop" {
  ami           = local.ami_id
  instance_type = "t3.micro"

  root_block_device {
        volume_size = 50
        volume_type = "gp3" # or "gp2", depending on your preference
  }

  user_data=file("workstation.sh")
  iam_instance_profile = aws_iam_instance_profile.roboshop.name
   tags =merge(
    local.common_tags,
    {
        Name = "${local.common_suffix_name}"
    }
  )
}

resource "aws_iam_instance_profile" "roboshop" {
  name = "K8-EKSCTL"
  role = "BastionTerraformAdmin"
}