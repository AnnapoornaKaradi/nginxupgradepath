locals {
build_agents_subnets = [
	"/subscriptions/a2ca26b7-774e-4207-801a-c45151ff310d/resourceGroups/rg-compute-common-eus2-01/providers/Microsoft.Network/virtualNetworks/vnet-build-dev2-eus2-02/subnets/snet-build-dev2-eus2-02",
	"/subscriptions/a2ca26b7-774e-4207-801a-c45151ff310d/resourceGroups/rg-compute-common-eus2-01/providers/Microsoft.Network/virtualNetworks/vnet-build-perf-eus2-02/subnets/snet-build-perf-eus2-02",
	"/subscriptions/a2ca26b7-774e-4207-801a-c45151ff310d/resourceGroups/rg-compute-common-wus2-01/providers/Microsoft.Network/virtualNetworks/vnet-build-perf-wus2-02/subnets/snet-build-perf-wus2-02",
	"/subscriptions/a2ca26b7-774e-4207-801a-c45151ff310d/resourceGroups/rg-compute-common-eus2-01/providers/Microsoft.Network/virtualNetworks/vnet-build-prod-eus2-02/subnets/snet-build-prod-eus2-02",
	"/subscriptions/a2ca26b7-774e-4207-801a-c45151ff310d/resourceGroups/rg-compute-common-wus2-01/providers/Microsoft.Network/virtualNetworks/vnet-build-prod-wus2-02/subnets/snet-build-prod-wus2-02",
	"/subscriptions/a2ca26b7-774e-4207-801a-c45151ff310d/resourceGroups/rg-compute-common-eus2-01/providers/Microsoft.Network/virtualNetworks/vnet-build-sandbox-eus2-02/subnets/snet-build-sandbox-eus2-02",
	"/subscriptions/a2ca26b7-774e-4207-801a-c45151ff310d/resourceGroups/rg-compute-common-wus2-01/providers/Microsoft.Network/virtualNetworks/vnet-build-sandbox-wus2-02/subnets/snet-build-sandbox-wus2-02",
	"/subscriptions/a2ca26b7-774e-4207-801a-c45151ff310d/resourceGroups/rg-compute-common-eus2-01/providers/Microsoft.Network/virtualNetworks/vnet-build-stage-eus2-02/subnets/snet-build-stage-eus2-02",
	"/subscriptions/a2ca26b7-774e-4207-801a-c45151ff310d/resourceGroups/rg-compute-common-wus2-01/providers/Microsoft.Network/virtualNetworks/vnet-build-stage-wus2-02/subnets/snet-build-stage-wus2-02",
	"/subscriptions/a2ca26b7-774e-4207-801a-c45151ff310d/resourceGroups/rg-compute-common-eus2-01/providers/Microsoft.Network/virtualNetworks/vnet-build-uat2-eus2-02/subnets/snet-build-uat2-eus2-02",
]

cognitive_instances_all = {

	app2 = {
		name      = "app"
		numeric   = "02"
		rg_ref    = "data"
		kind      = "ComputerVision"
		sku_name  = "S1"
		skip_secondary_site_type = false
		injections = {
			endpoint = {
				attr = "endpoint"
				kv_name = "ExosMacro--EXOS--AzureCognitiveReadApiUrl2"
				kv_ref = "app"
				app_config_name = "ExosMacro:EXOS:AzureCognitiveReadApiUrl2"
				app_config_ref = "app"
			}
			primary_access_key = {
				attr = "primary_access_key"
				kv_name = "ExosMacro--EXOS--AzureCognitiveReadApiKey2"
				kv_ref = "app"
				app_config_name = "ExosMacro:EXOS:AzureCognitiveReadApiKey2"
				app_config_ref = "app"
			}
			secondary_access_key = {
				attr = "secondary_access_key"
				kv_name = "ExosMacro--EXOS--AzureCognitiveReadApiKeySecondary2"
				kv_ref = "app"
				app_config_name = "ExosMacro:EXOS:AzureCognitiveReadApiKeySecondary2"
				app_config_ref = "app"
			}
		}
		network_acls = {
			default_action = "Deny"
			bypass = "None"
			ips = local.resource_firewall_with_services.ips
			subnet_ids = local.my_env_short == "dev2" ? concat(local.resource_firewall_with_services.subnet_ids, local.build_agents_subnets) : local.resource_firewall_with_services.subnet_ids
			subnet_id_refs = local.resource_firewall_with_services.subnet_id_refs
		}
	},
	openai = {
		name         = "oai"
		numeric      = "04"
		rg_ref       = "data"
		kind         = "OpenAI"
		sku_name     = "S0"
		region       = "northcentralus"
		region_short = "ncus"
		kv_ref       = "enc_oai"
		devops_spn_role_assignment = true
		skip_secondary_site_type = true
		injections = {
			endpoint = {
				attr = "endpoint"
				kv_name = "ExosMacro--EXOS--CognitiveOpenAIUrl1"
				kv_ref = "app"
				app_config_name = "ExosMacro:EXOS:CognitiveOpenAIUrl1"
				app_config_ref = "app"
			}
			primary_access_key = {
				attr = "primary_access_key"
				kv_name = "ExosMacro--EXOS--CognitiveOpenAIPrimaryKey1"
				kv_ref = "app"
				app_config_name = "ExosMacro:EXOS:CognitiveOpenAIPrimaryKey1"
				app_config_ref = "app"
			}
			secondary_access_key = {
				attr = "secondary_access_key"
				kv_name = "ExosMacro--EXOS--CognitiveOpenAISecondaryKey1"
				kv_ref = "app"
				app_config_name = "ExosMacro:EXOS:CognitiveOpenAISecondaryKey1"
				app_config_ref = "app"
			}
		}
		network_acls = {
			default_action = "Deny"
			bypass = "None"
			ips = local.resource_firewall_with_services.ips
			subnet_ids = local.my_env_short == "sandbox" ? concat(local.resource_firewall_with_services.subnet_ids, local.build_agents_subnets) : local.resource_firewall_with_services.subnet_ids
			subnet_id_refs = local.resource_firewall_with_services.subnet_id_refs
		}
		deployments = {
			gpt4omini = {
				model_name = "gpt-4o-mini"
				model_version = "2024-07-18"
				scale_capacity = {
					default = 200
					env_override = {
						prod = 4000
						perf = 2000
					}
				}
				scale_type = {
					default = "DataZoneStandard"
					env_override = {
					}
				}
			}
			gpt4o = {
				model_name = "gpt-4o"
				model_version = "2024-08-06"
				scale_capacity = {
					default = 500
				}
				scale_type = {
					default = "DataZoneStandard"
					env_override = {
					}
				}
			}
			gpt41mini = {
				model_name = "gpt-4.1-mini"
				model_version = "2025-04-14"
				scale_capacity = {
					default = 200
					env_override = {
						prod = 2000
						perf = 2000
					}
				}
				scale_type = {
					default = "DataZoneStandard"
					env_override = {
					}
				}
			}
			gpt41mini_pe = {
				model_name = "gpt-4.1-mini"
				model_version = "2025-04-14"
				scale_capacity = {
					default = 1000
					env_override = {
						prod = 4000
						perf = 4000
					}
				}
				scale_type = {
					default = "DataZoneStandard"
					env_override = {
					}
				}
			}
			gpt41 = {
				model_name = "gpt-4.1"
				model_version = "2025-04-14"
				scale_capacity = {
					default = 100
					env_override = {
						prod = 350
						perf = 350
					}
				}
				scale_type = {
					default = "DataZoneStandard"
					env_override = {
					}
				}
			}
			sl_title = {
				model_name = "gpt-4.1"
				model_version = "2025-04-14"
				scale_capacity = {
					default = 300
					env_override = {
						prod = 1499
						perf = 1500
					}
				}
				scale_type = {
					default = "DataZoneStandard"
					env_override = {
					}
				}
			}
			sl_valuations = {
				model_name = "gpt-4.1"
				model_version = "2025-04-14"
				scale_capacity = {
					default = 100
					env_override = {
						prod = 150
						perf = 150
					}
				}
				scale_type = {
					default = "DataZoneStandard"
					env_override = {
					}
				}
			}
			textembedada2 = {
				model_name = "text-embedding-ada-002"
				model_version = "2"
				scale_capacity = {
					default = 100
				}
				scale_type = {
					default = "Standard"
					env_override = {
					}
				}
			}
		}
		install_in = {
			envs = ["sandbox", "dev2", "uat2", "perf", "stage", "prod"]
		}
	}
}


openai_master_instance = {
		name         = "cog-oai-releasemgmt-ncus-01"
		rg_ref       = "infra_ncus"
		rg_name      = "rg-infra-common-ncus-01"
		kind         = "OpenAI"
		sku_name     = "S0"
		region       = "northcentralus"
		region_short = "ncus"
		kv_ref       = "enc_oai"
		install_in = {
			envs = ["sandbox", "dev2"]
		}
		network_acls = {
			default_action = "Deny"
			bypass = "None"
			ips = concat(local.resource_firewall_build_only.ips, local.firewall_enterprise_trusted_list.ips)
			subnet_ids = local.build_agents_subnets
			subnet_id_refs = []
		}
		deployments = {
			gpt4o = {
				model_name = "gpt-4o"
				model_version = "2024-08-06"
				scale_capacity = 200
			}
			gpt4omini = {
				model_name = "gpt-4o-mini"
				model_version = "2024-07-18"
				scale_capacity = 200
			}
			textembedada002 = {
				model_name = "text-embedding-ada-002"
				model_version = "2"
				scale_capacity = 25
			}
		}
	

}

// only allow region overrides in East US 2
cognitive_instances = { for k, v in local.cognitive_instances_all : k => v
	if (!contains(keys(v), "install_in")
			|| contains(lookup(lookup(v, "install_in", {}), "envs", []), local.my_env_short)) &&
				( !contains(keys(v), "region") || local.my_region_short == "eus2" ) &&
					!(try(v.skip_secondary_site_type, false) == true && local.site_type == "secondary")
}

cognitive_instances_for_injections = { for k, v in local.cognitive_instances_all : k => v
	if (
		(!contains(keys(v), "install_in")
			|| contains(lookup(lookup(v, "install_in", {}), "envs", []), local.my_env_short)) &&
				(!contains(keys(v), "region") || local.my_region_short == "eus2"
					|| (v.name == "oai" && local.site_type == "secondary")))
}
}
