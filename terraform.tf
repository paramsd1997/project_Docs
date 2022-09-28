       mkdir capstone
    
     cd capstone vi main.tf


        main.tf 
              
  resource "aws_instance" "ec222" {
   
  ami              =  var.ami

  instance_type    =  var.instance

  subnet_id        =  data.aws_subnet.selected.id

  security_groups =  [data.aws_security_group.sg.id]

  key_name        =  var.key_name
  
  count           =  var.count_no

  tags            =   {
 
  Name            = "jenkin_master"
}

root_block_device    {
  
 volume_size     =  "30"

  volume_type    =  "gp2"

  encrypted      =  true

  delete_on_termination  = true
}

}










                       data.tf  // for using the exitsting resources we use data block 
                         

                         data "aws_subnet" "selected" {
   filter {
    name   = "tag:Name" // filter the the existing resource according to tag name 
    values = [var.subnet_name] // subnet name should be present their for filltering
  }
}
data "aws_security_group" "sg" {
   filter {
    name   = "tag:Name"
    values = [var.security_group]
  }
}

                  
                           
                           variable.tf  // If we define variables means don't need to go inside resource file again and again 
                           
  variable "subnet_name" {
  type        = string
  default     = "2b"
  description = "The id of the machine image (AMI) to use for the server."
}
variable "key_name" {
  type        = string
  default     = "param"
}
variable "ami" {
  type        = string
  default     = "ami-01216e7612243e0ef"
}
variable "instance" {
  type        = string
  default     = "t2.xlarge"
}
variable "count_no" {
  type        = number
  default     = 1
}
variable "security_group" {
  type        = string
  default     = "all"
}

              
              
                provider.tf // credentials of AWS for launching the infra 
                
provider "aws" {   // AWS cloud provider 
region = "ap-south-1" // Zone for launching  the infra
  access_key = ""  // user access key and secret key
  secret_key = ""
  }
  


                

