provider "archive" {}

# Archive a single file.

data "archive_file" "config" {
  type        = "zip"
  source_file = "${path.module}/config.json"
  output_path = "${path.module}/files/config.zip"
}