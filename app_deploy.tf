resource "null_resource" "make-project-directory" {
  provisioner "remote-exec" {
    inline = [
      "mkdir /home/adminuser/web_erp"
    ]

    connection {
      type        = "ssh"
      user        = "adminuser"
      private_key = var.tenant_pem
      host        = azurerm_linux_virtual_machine.virtual_machine.public_ip_address
    }
  }
}

resource "null_resource" "copy-pre-deploy-script" {
  depends_on = [null_resource.make-project-directory]
  provisioner "file" {
    source      = "./scripts/pre-deploy.sh"               
    destination = "/home/adminuser/web_erp/pre-deploy.sh" 
    connection {
      type        = "ssh"
      user        = "adminuser"                                                     
      private_key = var.tenant_pem                    
      host        = azurerm_linux_virtual_machine.virtual_machine.public_ip_address 
    }
  }
}
resource "null_resource" "copy-env" {
  depends_on = [null_resource.copy-pre-deploy-script]
  provisioner "file" {
    # source      = "./env/.env" 
    content     = var.env_source_content
    destination = "/home/adminuser/web_erp/.env" 
    connection {
      type        = "ssh"
      user        = "adminuser"                                                     
      private_key = var.tenant_pem                 
      host        = azurerm_linux_virtual_machine.virtual_machine.public_ip_address 
    }
  }
}

resource "null_resource" "execute-pre-script" {
  depends_on = [null_resource.copy-env]

  provisioner "remote-exec" {
    inline = [
      "cd /home/adminuser/web_erp",
      "chmod +x pre-deploy.sh",
      "sh pre-deploy.sh",
    ]

    connection {
      type        = "ssh"
      user        = "adminuser"
      private_key = var.tenant_pem
      host        = azurerm_linux_virtual_machine.virtual_machine.public_ip_address
    }
  }
}
resource "null_resource" "cloning-repo" {
  depends_on = [null_resource.execute-pre-script]
  provisioner "remote-exec" {
    inline = [

      "cd web_erp",
      "git clone https://${var.git_pat}:x-oauth-basic@dev.azure.com/XcelProsDevOps/B2B-Applications/_git/WebERP",
      "cd WebERP",
      "git checkout ${var.git_branch}"
    ]

    connection {
      type        = "ssh"
      user        = "adminuser"
      private_key = var.tenant_pem
      host        = azurerm_linux_virtual_machine.virtual_machine.public_ip_address
    }
  }
}
resource "null_resource" "copy-deploy-script" {
  depends_on = [null_resource.cloning-repo]
  provisioner "file" {
    source      = "./scripts/deploy.sh"               
    destination = "/home/adminuser/web_erp/deploy.sh" 
    connection {
      type        = "ssh"
      user        = "adminuser"                                                     
      private_key = var.tenant_pem                   
      host        = azurerm_linux_virtual_machine.virtual_machine.public_ip_address 
    }
  }
}

resource "null_resource" "execute-deploy-script" {
  depends_on = [null_resource.copy-deploy-script]

  provisioner "remote-exec" {
    inline = [
      "cd /home/adminuser/web_erp",
      "chmod +x deploy.sh",
      "sh deploy.sh"
    ]

    connection {
      type        = "ssh"
      user        = "adminuser"
      private_key = var.tenant_pem
      host        = azurerm_linux_virtual_machine.virtual_machine.public_ip_address
    }
  }
}
