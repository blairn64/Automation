[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [object[]]$InputObject,
    [Parameter(Mandatory)]
    [string]$Path,
    [string]$Title = 'IT Operations Inventory Report'
)

if (-not $InputObject) {
    throw 'InputObject must contain at least one object.'
}

$preContent = @"
<style>
body { font-family: Segoe UI, Arial, sans-serif; margin: 2rem; }
h1 { margin-bottom: .25rem; }
.meta { color: #666; margin-bottom: 1rem; }
table { border-collapse: collapse; width: 100%; }
th, td { border: 1px solid #ccc; padding: .45rem; text-align: left; }
th { background: #eee; }
</style>
<div class='meta'>Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</div>
"@

$InputObject |
    ConvertTo-Html -Title $Title -PreContent "<h1>$Title</h1>$preContent" |
    Set-Content -Path $Path -Encoding utf8

Get-Item -LiteralPath $Path
