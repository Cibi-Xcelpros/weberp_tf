resource "null_resource" "self-shutdown" {
  depends_on = [null_resource.execute-post-script]

  provisioner "remote-exec" {
    inline = [
      "sudo shutdown -h ${var.shutdown_time}"
    ]

    connection {
      type        = "ssh"
      user        = "adminuser"
      private_key = var.tenant_pem
      host        = azurerm_linux_virtual_machine.virtual_machine.public_ip_address
    }
  }
}
resource "null_resource" "set_infra_expiry" {
  depends_on = [null_resource.execute-post-script]

  provisioner "remote-exec" {
    inline = [
      "echo './home/azureuser/web_erp/post-deploy.sh ${azurerm_resource_group.resource_group.name} ${var.sub_domain_name}' | at now + ${var.expiration_hours} hours"
    ]

    connection {
      type        = "ssh"
      user        = "azureuser"
      private_key = var.nginx_pem
      host        = var.nginx_server_ip
    }
  }
}

