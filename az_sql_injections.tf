locals {

az_sql_injections_iterator = { for k, v in local.az_sql_injections :
	k => merge(
		{
			use_kv = contains(keys(v), "kv_name")
			use_app_config = contains(keys(v), "app_config_name")
		},
		v
	)
}

az_sql_injections = {
	az_sql_app_primary_app_service_account_name = {
		kv_name = "ExosMacro--EXOS--AzureSqlDatabaseUserId"
		kv_ref = "app"
		kv_value = "svc-exos-app-01"
		app_config_name = "ExosMacro:AzureSqlDatabaseUserId"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_primary_app_service_account_password = {
		kv_name = "ExosMacro--EXOS--AzureSqlDatabasePassword"
		kv_ref = "app"
		kv_value = local.site_type == "primary" ? random_password.az_sql_local_login_passwords["app_svc-exos-app-01"].result : data.terraform_remote_state.baseinfra_01["partner"].outputs.az_sql["app"].passwords["svc-exos-app-01"]
		app_config_name = "ExosMacro:AzureSqlDatabasePassword"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_secondary_app_service_account_name = {
		kv_name = "ExosMacro--EXOS--AzureSqlDatabaseUserIdSecondary"
		kv_ref = "app"
		kv_value = "svc-exos-app-02"
		app_config_name = "ExosMacro:AzureSqlDatabaseUserIdSecondary"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_secondary_app_service_account_password = {
		kv_name = "ExosMacro--EXOS--AzureSqlDatabasePasswordSecondary"
		kv_ref = "app"
		kv_value = local.site_type == "primary" ? random_password.az_sql_local_login_passwords["app_svc-exos-app-02"].result : data.terraform_remote_state.baseinfra_01["partner"].outputs.az_sql["app"].passwords["svc-exos-app-02"]
		app_config_name = "ExosMacro:AzureSqlDatabasePasswordSecondary"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_primary_auctionworx_service_account_name = {
		kv_name = "AzureSQL--AzureSqlAuctionworxDatabaseUserId"
		kv_ref = "app"
		kv_value = "svc-exos-auctionworx-01"
		app_config_name = "AzureSqlAuctionworxDatabaseUserId"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_primary_auctionworx_service_account_password = {
		kv_name = "AzureSQL--AzureSqlAuctionworxDatabasePassword"
		kv_ref = "app"
		kv_value = local.site_type == "primary" ? random_password.az_sql_local_login_passwords["app_svc-exos-auctionworx-01"].result : data.terraform_remote_state.baseinfra_01["partner"].outputs.az_sql["app"].passwords["svc-exos-auctionworx-01"]
		app_config_name = "AzureSqlAuctionworxDatabasePassword"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_primary_bi_user_account_name = {
		kv_name = "ExosMacro--EXOS--AzureSqlDatabaseBiUserId"
		kv_ref = "dba"
		kv_value = "bi-exos-app-01"
		app_config_name = "ExosMacro:AzureSqlDatabaseBiUserId"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_primary_bi_user_account_password = {
		kv_name = "ExosMacro--EXOS--AzureSqlDatabaseBiPassword"
		kv_ref = "dba"
		kv_value = local.site_type == "primary" ? random_password.az_sql_local_login_passwords["app_bi-exos-app-01"].result : data.terraform_remote_state.baseinfra_01["partner"].outputs.az_sql["app"].passwords["bi-exos-app-01"]
		app_config_name = "ExosMacro:AzureSqlDatabaseBiPassword"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_secondary_bi_user_account_name = {
		kv_name = "ExosMacro--EXOS--AzureSqlDatabaseBiUserIdSecondary"
		kv_ref = "dba"
		kv_value = "bi-exos-app-02"
		app_config_name = "ExosMacro:AzureSqlDatabaseBiUserIdSecondary"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_secondary_bi_user_account_password = {
		kv_name = "ExosMacro--EXOS--AzureSqlDatabaseBiPasswordSecondary"
		kv_ref = "dba"
		kv_value = local.site_type == "primary" ? random_password.az_sql_local_login_passwords["app_bi-exos-app-02"].result : data.terraform_remote_state.baseinfra_01["partner"].outputs.az_sql["app"].passwords["bi-exos-app-02"]
		app_config_name = "ExosMacro:AzureSqlDatabaseBiPasswordSecondary"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_primary_pbiemb_user_account_name = {
		kv_name = "ExosMacro--EXOS--AzureSqlDatabasePowerBiEmbeddedUserId"
		kv_ref = "dba"
		kv_value = "pbiemb-exos-app-01"
		app_config_name = "ExosMacro:AzureSqlDatabasePowerBiEmbeddedUserId"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_primary_pbiemb_user_account_password = {
		kv_name = "ExosMacro--EXOS--AzureSqlDatabasePowerBiEmbeddedPassword"
		kv_ref = "dba"
		kv_value = local.site_type == "primary" ? random_password.az_sql_local_login_passwords["app_pbiemb-exos-app-01"].result : data.terraform_remote_state.baseinfra_01["partner"].outputs.az_sql["app"].passwords["pbiemb-exos-app-01"]
		app_config_name = "ExosMacro:AzureSqlDatabasePowerBiEmbeddedPassword"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_secondary_pbiemb_user_account_name = {
		kv_name = "ExosMacro--EXOS--AzureSqlDatabasePowerBiEmbeddedUserIdSecondary"
		kv_ref = "dba"
		kv_value = "pbiemb-exos-app-02"
		app_config_name = "ExosMacro:AzureSqlDatabasePowerBiEmbeddedUserIdSecondary"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_secondary_pbiemb_user_account_password = {
		kv_name = "ExosMacro--EXOS--AzureSqlDatabasePowerBiEmbeddedPasswordSecondary"
		kv_ref = "dba"
		kv_value = local.site_type == "primary" ? random_password.az_sql_local_login_passwords["app_pbiemb-exos-app-02"].result : data.terraform_remote_state.baseinfra_01["partner"].outputs.az_sql["app"].passwords["pbiemb-exos-app-02"]
		app_config_name = "ExosMacro:AzureSqlDatabasePowerBiEmbeddedPasswordSecondary"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_primary_reporting_user_account_name = {
		kv_name = "ExosMacro--EXOS--AzureSqlDatabaseReportingUserId"
		kv_ref = "app"
		kv_value = "reporting-exos-app-01"
		app_config_name = "ExosMacro:AzureSqlDatabaseReportingUserId"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_primary_reporting_user_account_password = {
		kv_name = "ExosMacro--EXOS--AzureSqlDatabaseReportingPassword"
		kv_ref = "app"
		kv_value = local.site_type == "primary" ? random_password.az_sql_local_login_passwords["app_reporting-exos-app-01"].result : data.terraform_remote_state.baseinfra_01["partner"].outputs.az_sql["app"].passwords["reporting-exos-app-01"]
		app_config_name = "ExosMacro:AzureSqlDatabaseReportingPassword"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_secondary_reporting_user_account_name = {
		kv_name = "ExosMacro--EXOS--AzureSqlDatabaseReportingUserIdSecondary"
		kv_ref = "app"
		kv_value = "reporting-exos-app-02"
		app_config_name = "ExosMacro:AzureSqlDatabaseReportingUserIdSecondary"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_secondary_reporting_user_account_password = {
		kv_name = "ExosMacro--EXOS--AzureSqlDatabaseReportingPasswordSecondary"
		kv_ref = "app"
		kv_value = local.site_type == "primary" ? random_password.az_sql_local_login_passwords["app_reporting-exos-app-02"].result : data.terraform_remote_state.baseinfra_01["partner"].outputs.az_sql["app"].passwords["reporting-exos-app-02"]
		app_config_name = "ExosMacro:AzureSqlDatabaseReportingPasswordSecondary"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_primary_debezium_user_account_name = {
		kv_name = "ExosMacro--EXOS--AzureSqlDebeziumDatabaseReaderUserId"
		kv_ref = "app"
		kv_value = "debezium-exos-app-01"
		app_config_name = "ExosMacro:AzureSqlDebeziumDatabaseReaderUserId"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_primary_debezium_user_account_password = {
		kv_name = "ExosMacro--EXOS--AzureSqlDebeziumDatabaseReaderPassword"
		kv_ref = "app"
		kv_value = local.site_type == "primary" ? random_password.az_sql_local_login_passwords["app_debezium-exos-app-01"].result : data.terraform_remote_state.baseinfra_01["partner"].outputs.az_sql["app"].passwords["debezium-exos-app-01"]
		#kv_value = local.site_type == "primary" ? random_password.az_sql_local_login_passwords["app_reporting-exos-app-02"].result : data.terraform_remote_state.baseinfra_01["partner"].outputs.az_sql["app"].passwords["reporting-exos-app-02"]
		app_config_name = "ExosMacro:AzureSqlDebeziumDatabaseReaderPassword"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_secondary_debezium_user_account_name = {
		kv_name = "ExosMacro--EXOS--AzureSqlDebeziumDatabaseReaderUserIdSecondary"
		kv_ref = "app"
		kv_value = "debezium-exos-app-01"
		app_config_name = "ExosMacro:AzureSqlDebeziumDatabaseReaderUserIdSecondary"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
	az_sql_app_secondary_debezium_user_account_password = {
		kv_name = "ExosMacro--EXOS--AzureSqlDebeziumDatabaseReaderPasswordSecondary"
		kv_ref = "app"
		kv_value = local.site_type == "primary" ? random_password.az_sql_local_login_passwords["app_debezium-exos-app-01"].result : data.terraform_remote_state.baseinfra_01["partner"].outputs.az_sql["app"].passwords["debezium-exos-app-01"]
		app_config_name = "ExosMacro:AzureSqlDebeziumDatabaseReaderPasswordSecondary"
		app_config_ref = "app"
		app_config_value = "kv_ref"
	}
}

}

#----- Add the Username to key vault
resource "azurerm_key_vault_secret" "az_sql_test_automation_username1" {
	name = "AzureSQL--AzureSqlDatabaseTestAutomationUserIdSecondary"
	value = "svc-exos-sql-auto-01"
	key_vault_id = data.terraform_remote_state.baseinfra_00["local"].outputs.key_vaults.env["dba"].id
}

#----- Add the password to key vault
resource "azurerm_key_vault_secret" "az_sql_test_automation_password1" {
	name = "AzureSQL--AzureSqlDatabaseTestAutomationPasswordSecondary"
	value = local.site_type == "primary" ? random_password.az_sql_local_login_passwords["app_svc-exos-sql-auto-01"].result : data.terraform_remote_state.baseinfra_01["partner"].outputs.az_sql["app"].passwords["svc-exos-sql-auto-01"]
	key_vault_id = data.terraform_remote_state.baseinfra_00["local"].outputs.key_vaults.env["dba"].id
}

#----- Add the Username to key vault
resource "azurerm_key_vault_secret" "az_sql_maintenance_username1" {
	name = "AzureSQL--AzureSqlDatabaseMaintenanceUserIdPrimary"
	value = "sql-maintenance-exos-app-01"
	key_vault_id = data.terraform_remote_state.baseinfra_00["local"].outputs.key_vaults.env["dba"].id
}

#----- Add the password to key vault
resource "azurerm_key_vault_secret" "az_sql_maintenance_password1" {
	name = "AzureSQL--AzureSqlDatabaseMaintenancePasswordPrimary"
	value = local.site_type == "primary" ? random_password.az_sql_local_login_passwords["app_sql-maintenance-exos-app-01"].result : data.terraform_remote_state.baseinfra_01["partner"].outputs.az_sql["app"].passwords["sql-maintenance-exos-app-01"]
	key_vault_id = data.terraform_remote_state.baseinfra_00["local"].outputs.key_vaults.env["dba"].id
}

#----- Add the Username to key vault
resource "azurerm_key_vault_secret" "az_sql_maintenance_username2" {
	name = "AzureSQL--AzureSqlDatabaseMaintenanceUserIdSecondary"
	value = "sql-maintenance-exos-app-02"
	key_vault_id = data.terraform_remote_state.baseinfra_00["local"].outputs.key_vaults.env["dba"].id
}

#----- Add the password to key vault
resource "azurerm_key_vault_secret" "az_sql_maintenance_password2" {
	name = "AzureSQL--AzureSqlDatabaseMaintenancePasswordSecondary"
	value = local.site_type == "primary" ? random_password.az_sql_local_login_passwords["app_sql-maintenance-exos-app-02"].result : data.terraform_remote_state.baseinfra_01["partner"].outputs.az_sql["app"].passwords["sql-maintenance-exos-app-02"]
	key_vault_id = data.terraform_remote_state.baseinfra_00["local"].outputs.key_vaults.env["dba"].id
}
