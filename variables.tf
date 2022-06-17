variable "key_access" {
  type = string
}
variable "key_secret"{
  type = string
}
variable "image_id" {
  type = string
}
variable "vpc_id"{
  type = string
  default = "vpc-01f8e0ace904bdd9e"
}
variable "cidr" {
type = string
default = "10.33.13.0/24"
}
variable "security_group_id"{
  type = string
}
variable "availability_zone_names" {
  type    = list(string)
  default = ["eu-west-1a"]
}
variable "tag_user"{
  type = string
}
variable "docker_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 8300
      external = 8300
      protocol = "tcp"
    }
  ]
}