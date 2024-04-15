provider "local" {}
provider "random" {}

resource "random_integer" "randint" {
    min = 1
    max = 100
  
}

output "random" {
    value = "${random_integer.randint.result}"
  
}