resource "azurerm_resource_group" "elastic-resourcegroup" {
  name     = "${var.product}-elastic-search-${var.env}"
  location = "${var.location}"

  tags = "${merge(var.common_tags,
    map("lastUpdated", "${timestamp()}")
    )}"
}

locals {
  artifactsBaseUrl = "https://raw.githubusercontent.com/elastic/azure-marketplace/6.3.0/src"
  templateUrl = "${local.artifactsBaseUrl}/mainTemplate.json"
  elasticVnetName = "elastic-search-vnet"
  elasticSubnetName = "elastic-search-subnet"
  vNetLoadBalancerIp = "10.112.0.4"
}

module "elastic" {
  source = "git@github.com:hmcts/cnp-module-elk.git?ref=master"
  product = "${var.product}"
  location = "${var.location}"
  env = "${var.env}"
  common_tags = "${var.common_tags}"
}