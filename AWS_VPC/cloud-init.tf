data "template_file" "cld-init" {
    template = file("init.cfg")
}

data "template_cloudinit_config" "install_apc_cfg" {
    gzip = false
    base64_encode = false

    part {
        filename = "init.cfg"
        content_type = "text/cloud-config"
        content = data.template_file.cld-init.rendered
    }
} 
  
