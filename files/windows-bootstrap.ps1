$ansibleRepo = ""
$skipTags = ""
$extraVars = "deploy_mode=local"

function retrieveSysConfig {
	$serial = Get-WmiObject win32_baseboard | FL SerialNumber
}

if (Test-Connection get-scoop.sh -Count 1 -Quiet) {
	Set-ExecutionPolicy -ExecutionPolicy RemoteSignd -Scope CurrentUser
	irm get.scoop.sh -outfile $env:TMP\scoop-install.ps1

	$env.TMP\scoop-install.ps1 -RunAsAdmin | Out-Null

    # install minimal required packages with scoop
	if ($LASTEXITCODE) {
	    $packages = @(
	    	"git",
	    	"mobaxterm")

        scoop bucket add extras
	    foreach ($package in $packages) {
	    	scoop install $package
	    }

	    # ensure python3 and ansible are present on system
	    mobaxterm -exitwhendone -exec "apt-cyg install -y python3"
	    mobaxterm -exitwhendone -exec "pip3 install pip --upgrade --no-warn-script-location"
	    mobaxterm -exitwhendone -exec "pip3 install ansible"
	    mobaxterm -exitwhendone -exec "ansible-galaxy collection install commnity.windows"
	}

	# ensure local ansible configuration is present on system
	if (Test-Connection $ansibleRepo.split("/").[2] -Count 1 -Quiet) {
	    mobaxterm -exitwhendone -exec "ansible-pull -U $ansibleRepo -i localhost --tags init"

	    [System.Environment]::SetEnvironmentVariable('ansiDeploySkip', $skipTags)
		mobaxterm -exitwhendone -exec "ansible-pull -U $ansibleRepo -i localhost --skip-tags $skipTags --extra-vars $extraVars"
	}
}