provider "null" {}

resource "null_resource" "test" {
    triggers = {
      always_run = timestamp()
    }
  
    provisioner "local-exec" {
        command = "sh ${path.module}/test.sh"      
    }
}