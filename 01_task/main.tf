provider "local" {}

resource "local_file" "file" {
    content = "Hello, Terrform!"
    filename = "${path.module}/hello.txt"
  
}