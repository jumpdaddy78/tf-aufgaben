provider "local" {}
provider "http" {}

data "http" "chuck" {
  url = "https://api.chucknorris.io/jokes/random"
}

resource "local_file" "chuck_joke" {
    content = data.http.chuck.response_body
    filename = "${path.module}/chuck_joke.json"
  
}