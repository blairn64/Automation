# Intune operations lab

Demonstrates endpoint compliance reporting with a safe fixture mode and an optional Microsoft Graph mode for authorised environments.

## Run the portfolio demo

```powershell
./Get-IntuneDeviceCompliance.ps1 -Mode Fixture
```

## Live mode

Authenticate with Microsoft Graph using the required delegated/application permissions, then run:

```powershell
./Get-IntuneDeviceCompliance.ps1 -Mode Graph -OutputPath ./intune-devices.csv
```

The repository contains synthetic device data only.