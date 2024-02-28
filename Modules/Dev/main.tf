module "dev-vpc" {
    source = "../Local"
    vpcname                         = "dev01-vpc"
    cidr                            = "10.0.2.0/24"
    enable_dns_support              = "true"
    enable_ipv6                     = "true"
    vpcenvironment                  = "Development-Engineering"
}
  
