resource "null_resource" "execute-post-script" {
  depends_on = [null_resource.execute-deploy-script]

  provisioner "remote-exec" {
    inline = [
      "cd /home/azureuser/web_erp",
      "python3 gen_nginx_config.py ${var.sub_domain_name} ${azurerm_linux_virtual_machine.virtual_machine.public_ip_address}",
      "sudo cp ${var.sub_domain_name} /etc/nginx/sites-available/${var.sub_domain_name}",
      "sudo nginx -s reload"
    ]

    connection {
      type        = "ssh"
      user        = "azureuser"
      private_key = var.nginx_pem
      host        = var.nginx_server_ip
    }
  }
}

