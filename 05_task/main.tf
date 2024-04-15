provider "template_file" {}

data "template_file" "config" {
  template = "${file("${path.module}/config.json")}"
  vars = {
    username = "admin"
    password = "password"
  }
}