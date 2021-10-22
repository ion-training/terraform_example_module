resource "null_resource" "print_on_cli_hello_world" {
  provisioner "local-exec" {
    command = "echo 'Hello World!'"
  }
}