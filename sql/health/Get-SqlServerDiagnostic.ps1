[CmdletBinding()]
param(
    [string]$Instance = 'localhost',
    [int]$SlowQuerySeconds = 5
)

$ErrorActionPreference = 'Stop'

try {
    Import-Module SqlServer -ErrorAction Stop
}
catch {
    Write-Error 'SqlServer PowerShell module is required for this diagnostic.'
    exit 1
}

$query = @"
SELECT
    @@SERVERNAME AS ServerName,
    SERVERPROPERTY('ProductVersion') AS ProductVersion,
    SERVERPROPERTY('Edition') AS Edition,
    SYSDATETIME() AS CheckedAt;

SELECT TOP (20)
    r.session_id,
    r.status,
    r.command,
    r.cpu_time,
    r.total_elapsed_time / 1000.0 AS elapsed_seconds,
    DB_NAME(r.database_id) AS database_name
FROM sys.dm_exec_requests AS r
WHERE r.session_id <> @@SPID
ORDER BY r.total_elapsed_time DESC;
"@

Invoke-Sqlcmd -ServerInstance $Instance -Query $query -ErrorAction Stop
