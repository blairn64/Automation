[CmdletBinding()]
param(
    [string] $Server = 'HQ-SQL01',
    [string] $Database = 'NorthstarOperations'
)

$ErrorActionPreference = 'Stop'
$query = @"
IF DB_ID('$Database') IS NULL CREATE DATABASE [$Database];
USE [$Database];
IF OBJECT_ID('dbo.TelemetrySample') IS NULL
CREATE TABLE dbo.TelemetrySample (
    Id int IDENTITY(1,1) PRIMARY KEY,
    Site nvarchar(64) NOT NULL,
    Metric nvarchar(64) NOT NULL,
    MetricValue decimal(18,2) NOT NULL,
    RecordedAt datetime2 NOT NULL DEFAULT SYSUTCDATETIME()
);
INSERT INTO dbo.TelemetrySample (Site,Metric,MetricValue)
VALUES ('Plant-East','LineRate',97.4),('Plant-West','QueueDepth',12.0),('HQ','ActiveSessions',842.0);
"@

Write-Host "Preparing synthetic Northstar operations workload for $Server / $Database"
Write-Output $query
# Execute with Invoke-Sqlcmd where the SqlServer module and authorised SQL instance are available.
