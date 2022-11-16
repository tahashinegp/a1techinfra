variable "public_subnet" {
   description = "The public subnet IDs assigned to the Jenkins server"
}

variable "vpc_id" {
   description = "ID of the VPC"
   type        = string
}


variable "tags"{

   type        = map(string)
               
}

variable "security_group" {
}