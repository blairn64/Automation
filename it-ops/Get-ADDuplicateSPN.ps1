[CmdletBinding()]
param(
    [string]$OutputPath
)

Import-Module ActiveDirectory -ErrorAction Stop

$spnMap = @{}
$objects = Get-ADObject -LDAPFilter '(|(objectClass=user)(objectClass=computer))' -Properties servicePrincipalName,sAMAccountName

foreach ($object in $objects) {
    foreach ($spn in @($object.servicePrincipalName)) {
        if (-not $spnMap.ContainsKey($spn)) {
            $spnMap[$spn] = [System.Collections.Generic.List[string]]::new()
        }
        $spnMap[$spn].Add($object.DistinguishedName)
    }
}

$duplicates = foreach ($entry in $spnMap.GetEnumerator() | Where-Object { $_.Value.Count -gt 1 }) {
    [pscustomobject]@{
        SPN = $entry.Key
        AccountCount = $entry.Value.Count
        Accounts = $entry.Value -join ' | '
        Status = 'DUPLICATE'
    }
}

if ($duplicates) {
    $duplicates | Sort-Object SPN | Format-Table -Wrap -AutoSize
} else {
    Write-Output 'No duplicate SPNs detected.'
}

if ($OutputPath) { $duplicates | Export-Csv -Path $OutputPath -NoTypeInformation }
