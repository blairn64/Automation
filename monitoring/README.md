# Windows monitoring

A small PowerShell health-check example that turns Terminal Services session data into structured JSON.

## What it demonstrates

- Windows command-line integration with `qwinsta`
- Parsing semi-structured administrative output
- Optional filtering of disconnected sessions
- Structured JSON output for monitoring systems and automation
- Remote-target support through a parameterized computer name

## Example

```powershell
./Get-WindowsSessionHealth.ps1 -ComputerName 'localhost'
./Get-WindowsSessionHealth.ps1 -ComputerName 'server01' -IncludeDisconnected
```

Use only on systems you are authorised to query.

## Portfolio note

This is intentionally small: the interesting engineering point is the normalization of a legacy administrative interface into structured data that can be consumed by another system.
