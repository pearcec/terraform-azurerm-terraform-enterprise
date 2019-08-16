# ============================================================ REQUIRED
variable "license_file" {
  type        = "string"
  description = "Path to the Replicated license file."
}

variable "primary_count" {
  description = "The number of primary virtual machines to create."
}

variable "secondary_count" {
  description = "The number of secondary virtual machines to create."
}

variable "distribution" {
  type        = "string"
  description = "Type of linux distribution to use. (ubuntu or rhel)"
}

variable "resource_group_name" {
  type        = "string"
  description = "An existing Azure Resource Group to deploy into."
}

variable "virtual_network_name" {
  type        = "string"
  description = "An existing Azure Virtual Network to deploy into"
}

variable "application_subnet_name" {
  type        = "string"
  description = "An existing Azure Subnet to deploy into"
}

variable "key_vault_name" {
  type        = "string"
  description = "The name of an existing key vault to use for certificate generation."
}

variable "domain" {
  type        = "string"
  description = "An Azure hosted DNS domain to use for DNS records"
}

variable "tls_pfx_certificate" {
  type        = "string"
  description = "The path to a PFX certificate for front end SSL communication."
}

variable "tls_pfx_certificate_password" {
  type        = "string"
  description = "The password for the associated SSL certificate."
}

# ============================================================ OPTIONAL

variable "key_vault_resource_group_name" {
  type        = "string"
  description = "The existing Azure Resource Group where the key vault is stored, defaults to the main resource group if not set."
  default     = ""
}

variable "airgap_mode_enable" {
  type        = "string"
  description = "install in airgap mode"
  default     = "False"
}

variable "airgap_installer_url" {
  type        = "string"
  description = "URL to replicated's airgap installer package"
  default     = "https://install.terraform.io/installer/replicated-v5.tar.gz"
}

variable "airgap_package_url" {
  type        = "string"
  description = "Signed URL to download the package"
  default     = ""
}

variable "azure_es_account_key" {
  type        = "string"
  description = "The Azure account key for external services"
  default     = ""
}

variable "azure_es_account_name" {
  type        = "string"
  description = "The Azure account name for external services"
  default     = ""
}

variable "azure_es_container" {
  type        = "string"
  description = "The Azure container for external services"
  default     = ""
}

variable "default_username" {
  type        = "string"
  description = "The default user to use"
  default     = "ubuntu"
}

variable "dns_ttl" {
  type        = "string"
  description = "The TTL for dns records."
  default     = "120"
}

variable "domain_resource_group_name" {
  type        = "string"
  description = "The name of the resource group where the domain name resides, if not set the main resource group will be used."
  default     = ""
}

variable "encryption_password" {
  type        = "string"
  description = "The password for data encryption in non-external services modes."
  default     = ""
}

variable "external_services" {
  type        = "string"
  description = "mode to install ('True' or 'False')"
  default     = "False"
}

variable "http_proxy_url" {
  type        = "string"
  description = "HTTP(S) Proxy URL"
  default     = ""
}

variable "iact_subnet_list" {
  type        = "string"
  description = "IP Cidr Mask to allow to access Initial Admin Creation Token (IACT) API. [Terraform Docs](https://www.terraform.io/docs/enterprise/private/automating-initial-user.html)"
  default     = ""
}

variable "iact_subnet_time_limit" {
  type        = "string"
  description = "Amount of time to allow access to IACT API after initial boot"
  default     = ""
}

variable "import_key" {
  type        = "string"
  description = "An additional ssh pub key to import to all machines"
  default     = ""
}

variable "os_disk_size" {
  type        = "string"
  description = "The size in Gb for the OS disk of the primary seed virtual machine"
  default     = "100"
}

variable "postgresql_user" {
  type        = "string"
  description = "user to connect to external postgresql database as"
  default     = ""
}

variable "postgresql_password" {
  type        = "string"
  description = "password to connect to external postgresql database as"
  default     = ""
}

variable "postgresql_address" {
  type        = "string"
  description = "address to connect to external postgresql database at"
  default     = ""
}

variable "postgresql_database" {
  type        = "string"
  description = "database name to use in exetrnal postgresql database"
  default     = ""
}

variable "postgresql_extra_params" {
  type        = "string"
  description = "additional connection string parameters (must be url query params)"
  default     = ""
}

variable "primary_vm_size" {
  type        = "string"
  description = "The Azure VM Size to use."
  default     = "Standard_D4s_v3"
}

variable "installer_tool_url" {
  type        = "string"
  description = "URL to the cluster installer tool"
  default     = "https://install.terraform.io/installer/ptfe.zip"
}

variable "secondary_vm_size" {
  type        = "string"
  description = "The Azure VM Size to use (will use primary_vm_size if not set)."
  default     = ""
}

variable "storage_image" {
  type        = "map"
  description = "A list of the data to define the os version image to build from"

  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

variable "vm_size_tier" {
  type        = "string"
  description = "The tier for the vms (must be 'Standard' or 'Basic') and must match with vm_size"
  default     = "Standard"
}

# ============================================================ MISC

locals {
  assistant_port             = 23010
  rendered_secondary_vm_size = "${coalesce(var.secondary_vm_size, var.primary_vm_size)}"
}

resource "random_string" "install_id" {
  length  = 8
  special = false
  upper   = false
}