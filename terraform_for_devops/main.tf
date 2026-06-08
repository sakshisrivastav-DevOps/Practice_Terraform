resource "local_file" "my_file" {
   filename = "firstfile.txt"
   content = "hello"
   file_permission = "777"
}