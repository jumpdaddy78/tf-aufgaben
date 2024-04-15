provider "random" {}

resource "random_password" "rnd_pass" {
  length = 12
  upper = true
  lower = true
  numeric = true
  special = false
}

output "random_pass" {
    sensitive = true
    value = "${random_password.rnd_pass.result}"
}