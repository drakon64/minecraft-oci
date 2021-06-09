#!/usr/bin/env pwsh

Param (
	[Parameter(Mandatory, ParameterSetName="Config")] [Switch] $Config,
	[Parameter(Mandatory, ParameterSetName="NewServer")] [Switch] $NewServer,
	[Parameter(Mandatory, ParameterSetName="RestoreBackup")] [Switch] $RestoreBackup,
	[Parameter(Mandatory, ParameterSetName="UpdateServer")] [Switch] $UpdateServer,
	[Parameter(Mandatory, ParameterSetName="RunPlaybook")] [Switch] $RunPlaybook,

	[Parameter(Mandatory, ParameterSetName="Config")] [Parameter(Mandatory, ParameterSetName="NewServer")] [Parameter(Mandatory, ParameterSetName="RestoreBackup")] [Parameter(Mandatory, ParameterSetName="UpdateServer")] [ValidateSet("bedrock", "java", "paper", "geyser")] [String] $Edition,
	[Parameter(Mandatory, ParameterSetName="Config")] [Parameter(Mandatory, ParameterSetName="NewServer")] [Parameter(Mandatory, ParameterSetName="RestoreBackup")] [Parameter(Mandatory, ParameterSetName="UpdateServer")] [String] $IpAddress,
	[Parameter(Mandatory, ParameterSetName="Config")] [Parameter(Mandatory, ParameterSetName="NewServer")] [Parameter(Mandatory, ParameterSetName="RestoreBackup")] [Parameter(Mandatory, ParameterSetName="UpdateServer")] [ValidateSet("true", "false")] [String] $Eula,
	[Parameter(Mandatory, ParameterSetName="Config")] [Parameter(Mandatory, ParameterSetName="NewServer")] [Parameter(Mandatory, ParameterSetName="RestoreBackup")] [Parameter(Mandatory, ParameterSetName="UpdateServer")] [String] $BucketName,

	[Parameter(Mandatory, ParameterSetName="Config")] [Parameter(Mandatory, ParameterSetName="NewServer")] [Parameter(Mandatory, ParameterSetName="RestoreBackup")] [Parameter(Mandatory, ParameterSetName="UpdateServer")] [String] $Timezone,

	[Parameter(ParameterSetName="NewServer")] [Parameter(ParameterSetName="UpdateServer")] [Switch] $ViaVersion,

	[Parameter(ParameterSetName="RestoreBackup")] [String] $BackupVersion
)

If ($ViaVersion) {
	[String] $ViaVersion = "true"
} Else {
	[String] $ViaVersion = "false"
}

If ($Config) {
	If ($Edition -eq "bedrock") {
		"$IpAddress edition=bedrock type=bedrock command='/home/minecraft/bedrock/bedrock_server' new_server=false update_server=false restore_backup=false backup_version= viaversion=$ViaVersion bucket_name=$BucketName timezone=$Timezone" | Out-File -FilePath ansible/inventory
	} ElseIf ($Edition -eq "java" -Or $Edition -eq "paper" -Or $Edition -eq "geyser") {
		"$IpAddress edition=$Edition type=java command='/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui' eula=$Eula new_server=false update_server=false restore_backup=false backup_version= viaversion=$ViaVersion bucket_name=$BucketName timezone=$Timezone" | Out-File -FilePath ansible/inventory
	}
}
ElseIf ($NewServer) {
	If ($Edition -eq "bedrock") {
		"$IpAddress edition=bedrock type=bedrock command='/home/minecraft/bedrock/bedrock_server' new_server=true update_server=false restore_backup=false backup_version= viaversion=$ViaVersion bucket_name=$BucketName timezone=$Timezone" | Out-File -FilePath ansible/inventory
	} ElseIf ($Edition -eq "java" -Or $Edition -eq "paper" -Or $Edition -eq "geyser") {
		"$IpAddress edition=$Edition type=java command='/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui' eula=$Eula new_server=true update_server=false restore_backup=false backup_version= viaversion=$ViaVersion bucket_name=$BucketName timezone=$Timezone" | Out-File -FilePath ansible/inventory
	}
}
ElseIf ($RestoreBackup) {
	If ($Edition -eq "bedrock") {
		"$IpAddress edition=bedrock type=bedrock command='/home/minecraft/bedrock/bedrock_server' new_server=true update_server=false restore_backup=true backup_version=$BackupVersion viaversion=$ViaVersion bucket_name=$BucketName timezone=$Timezone" | Out-File -FilePath ansible/inventory
	} ElseIf ($Edition -eq "java" -Or $Edition -eq "paper" -Or $Edition -eq "geyser") {
		"$IpAddress edition=$Edition type=java command='/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui' eula=$Eula new_server=true update_server=false restore_backup=true backup_version=$BackupVersion viaversion=$ViaVersion bucket_name=$BucketName timezone=$Timezone" | Out-File -FilePath ansible/inventory
	}
}
ElseIf ($UpdateServer) {
	If ($Edition -eq "bedrock") {
		"$IpAddress edition=bedrock type=bedrock command='/home/minecraft/bedrock/bedrock_server' new_server=false update_server=true restore_backup=false backup_version= viaversion=$ViaVersion bucket_name=$BucketName timezone=$Timezone" | Out-File -FilePath ansible/inventory
	} ElseIf ($Edition -eq "java" -Or $Edition -eq "paper" -Or $Edition -eq "geyser") {
		"$IpAddress edition=$Edition type=java command='/usr/bin/java -Xmx1024M -Xms1024M -jar server.jar nogui' eula=$Eula new_server=false update_server=true restore_backup=false backup_version= viaversion=$ViaVersion bucket_name=$BucketName timezone=$Timezone" | Out-File -FilePath ansible/inventory
	}
}
ElseIf ($RunPlaybook) {
	ansible-playbook --diff --inventory ansible/inventory --user ubuntu --become ansible/minecraft.yml
}
