#!/usr/bin/env pwsh

Param (
	[Parameter(Mandatory, ParameterSetName="Config")] [Switch] $Config,
	[Parameter(Mandatory, ParameterSetName="NewServer")] [Switch] $NewServer,
	[Parameter(Mandatory, ParameterSetName="RestoreBackup")] [Switch] $RestoreBackup,
	[Parameter(Mandatory, ParameterSetName="UpdateServer")] [Switch] $UpdateServer,
	[Parameter(Mandatory, ParameterSetName="BedrockConnect")] [Switch] $BedrockConnect,
	[Parameter(Mandatory, ParameterSetName="RunPlaybook")] [Switch] $RunPlaybook,
	[Parameter(Mandatory, ParameterSetName="RunBedrockConnectPlaybook")] [Switch] $RunBedrockConnectPlaybook,

	[Parameter(Mandatory, ParameterSetName="Config")] [Parameter(Mandatory, ParameterSetName="NewServer")] [Parameter(Mandatory, ParameterSetName="RestoreBackup")] [Parameter(Mandatory, ParameterSetName="UpdateServer")] [ValidateSet("bedrock", "java", "paper", "geyser")] [String] $Edition,
	[Parameter(Mandatory, ParameterSetName="Config")] [Parameter(Mandatory, ParameterSetName="NewServer")] [Parameter(Mandatory, ParameterSetName="RestoreBackup")] [Parameter(Mandatory, ParameterSetName="UpdateServer")] [Parameter(Mandatory, ParameterSetName="BedrockConnect")] [String] $IpAddress,
	[Parameter(Mandatory, ParameterSetName="Config")] [Parameter(Mandatory, ParameterSetName="NewServer")] [Parameter(Mandatory, ParameterSetName="RestoreBackup")] [Parameter(Mandatory, ParameterSetName="UpdateServer")] [ValidateSet("true", "false")] [String] $Eula,
	[Parameter(Mandatory, ParameterSetName="Config")] [Parameter(Mandatory, ParameterSetName="NewServer")] [Parameter(Mandatory, ParameterSetName="RestoreBackup")] [Parameter(Mandatory, ParameterSetName="UpdateServer")] [String] $BucketName,

	[Parameter(Mandatory, ParameterSetName="Config")] [Parameter(Mandatory, ParameterSetName="NewServer")] [Parameter(Mandatory, ParameterSetName="RestoreBackup")] [Parameter(Mandatory, ParameterSetName="UpdateServer")] [Parameter(Mandatory, ParameterSetName="BedrockConnect")] [String] $Timezone,

	[Parameter(ParameterSetName="RestoreBackup")] [String] $BackupVersion,

	[Parameter(Mandatory, ParameterSetName="Config")] [Parameter(Mandatory, ParameterSetName="NewServer")] [Parameter(Mandatory, ParameterSetName="RestoreBackup")] [Parameter(Mandatory, ParameterSetName="UpdateServer")] [ValidateSet("true", "false")] [String] $RestorePermissions
)

If ($Config) {
	If ($Edition -eq "bedrock") {
		"$IpAddress edition=bedrock type=bedrock command='/home/minecraft/bedrock/bedrock_server' new_server=false update_server=false restore_backup=false restore_permissions=$RestorePermissions opsfile=permissions backup_version= bucket_name=$BucketName timezone=$Timezone" | Out-File -FilePath ansible/inventory
	} ElseIf ($Edition -eq "java" -Or $Edition -eq "paper" -Or $Edition -eq "geyser") {
		"$IpAddress edition=$Edition type=java command='/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui' eula=$Eula new_server=false update_server=false restore_backup=false restore_permissions=$RestorePermissions opsfile=ops backup_version= bucket_name=$BucketName timezone=$Timezone" | Out-File -FilePath ansible/inventory
	}
}
ElseIf ($NewServer) {
	If ($Edition -eq "bedrock") {
		"$IpAddress edition=bedrock type=bedrock command='/home/minecraft/bedrock/bedrock_server' new_server=true update_server=false restore_backup=false restore_permissions=$RestorePermissions opsfile=permissions backup_version= bucket_name=$BucketName timezone=$Timezone" | Out-File -FilePath ansible/inventory
	} ElseIf ($Edition -eq "java" -Or $Edition -eq "paper" -Or $Edition -eq "geyser") {
		"$IpAddress edition=$Edition type=java command='/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui' eula=$Eula new_server=true update_server=false restore_backup=false restore_permissions=$RestorePermissions opsfile=ops backup_version= bucket_name=$BucketName timezone=$Timezone" | Out-File -FilePath ansible/inventory
	}
}
ElseIf ($RestoreBackup) {
	If ($Edition -eq "bedrock") {
		"$IpAddress edition=bedrock type=bedrock command='/home/minecraft/bedrock/bedrock_server' new_server=true update_server=false restore_backup=true restore_permissions=$RestorePermissions opsfile=permissions backup_version=$BackupVersion bucket_name=$BucketName timezone=$Timezone" | Out-File -FilePath ansible/inventory
	} ElseIf ($Edition -eq "java" -Or $Edition -eq "paper" -Or $Edition -eq "geyser") {
		"$IpAddress edition=$Edition type=java command='/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui' eula=$Eula new_server=true update_server=false restore_backup=true restore_permissions=$RestorePermissions opsfile=ops backup_version=$BackupVersion bucket_name=$BucketName timezone=$Timezone" | Out-File -FilePath ansible/inventory
	}
}
ElseIf ($UpdateServer) {
	If ($Edition -eq "bedrock") {
		"$IpAddress edition=bedrock type=bedrock command='/home/minecraft/bedrock/bedrock_server' new_server=false update_server=true restore_backup=false restore_permissions=$RestorePermissions opsfile=permissions backup_version= bucket_name=$BucketName timezone=$Timezone" | Out-File -FilePath ansible/inventory
	} ElseIf ($Edition -eq "java" -Or $Edition -eq "paper" -Or $Edition -eq "geyser") {
		"$IpAddress edition=$Edition type=java command='/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui' eula=$Eula new_server=false update_server=true restore_backup=false restore_permissions=$RestorePermissions opsfile=ops backup_version= bucket_name=$BucketName timezone=$Timezone" | Out-File -FilePath ansible/inventory
	}
}
ElseIf ($BedrockConnect) {
	"$IpAddress edition=bedrockconnect type=bedrockconnect command='/usr/bin/java -jar BedrockConnect.jar nodb=true custom_servers=/home/minecraft/bedrockconnect/custom_servers.json user_servers=false featured_servers=false' timezone=$Timezone" | Out-File -FilePath ansible/inventory
}
ElseIf ($RunPlaybook) {
	ansible-playbook --diff --inventory ansible/inventory --user ubuntu --become ansible/minecraft.yml
}
ElseIf ($RunBedrockConnectPlaybook) {
	ansible-playbook --diff --inventory ansible/inventory --user ubuntu --become ansible/bedrockconnect.yml
}
