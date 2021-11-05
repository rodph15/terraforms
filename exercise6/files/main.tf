
resource "local_file" "myfile" {
  content = var.environment == "Production" ? upper(format("RG-%s",var.app_name)) : upper(format("RG-%s-%s",var.app_name,var.environment))
  filename = "../mytextfile.txt"
}