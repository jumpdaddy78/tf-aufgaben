provider "local" {}
provider "random" {}

resource "random_string" "rnd_filename" {
    length = 10
    special = false
    upper = false
    numeric = false
}
resource "local_file" "logfile" {
    content = "test-content"
    filename = "${path.module}/log${random_string.rnd_filename.result}.txt"
  
}