[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string[]]$ComputerName,
    [Parameter(Mandatory)]
    [string[]]$ServiceName,
    [pscredential]$Credential,
    [string]$OutputPath
)

$results = foreach ($computer in $ComputerName) {
    try {
        $invokeParams = @{
            ComputerName = $computer
            ScriptBlock  = {
                param($Names)
                foreach ($name in $Names) {
                    try {
                        $service = Get-Service -Name $name -ErrorAction Stop
                        [pscustomobject]@{
                            ServiceName = $service.Name
                            DisplayName = $service.DisplayName
                            Status      = $service.Status
                            StartType   = $service.StartType
                        }
                    }
                    catch {
                        [pscustomobject]@{
                            ServiceName = $name
                            DisplayName = $null
                            Status      = 'Missing'
                            StartType   = $null
                        }
                    }
                }
            }
            ArgumentList = (, $ServiceName)
        }
        if ($Credential) { $invokeParams.Credential = $Credential }

        $remote = Invoke-Command @invokeParams -ErrorAction Stop
        foreach ($service in $remote) {
            [pscustomobject]@{
                ComputerName = $computer
                ServiceName  = $service.ServiceName
                DisplayName  = $service.DisplayName
                Status       = $service.Status
                StartType    = $service.StartType
                Health       = if ($service.Status -eq 'Running') { 'OK' } else { 'CHECK' }
            }
        }
    }
    catch {
        [pscustomobject]@{
            ComputerName = $computer
            ServiceName  = $null
            DisplayName  = $null
            Status       = $null
            StartType    = $null
            Health       = "ERROR: $($_.Exception.Message)"
        }
    }
}

$results | Format-Table -AutoSize
if ($OutputPath) { $results | Export-Csv -Path $OutputPath -NoTypeInformation }
