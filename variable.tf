variable "prefix" {
  default = "acp"
}

variable "region" {
  default = "europe-west4"
}

variable "machine_type" {
  default = "n1-standard-1"
}

variable "image" {
  default = "centos-cloud/centos-7"
}

variable "disk_size_gb" {
  default = "100"
}

variable "disk_type" {
  default = "pd-ssd"
}

variable "gcp_ssh_key" {
  default = "~/.ssh/manawa-public.pub"
}

variable "ssh_user_name" {
  default = "cloud-user"
}

variable "num_masters" {
  default = "3"
}

variable "num_nodes" {
  default = "2"
}

variable "num_infra" {
  default = "2"
}
