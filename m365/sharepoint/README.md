# SharePoint operations lab

Inventory SharePoint sites using synthetic fixtures or Microsoft Graph in an authorised tenant.

```powershell
./Get-SharePointSiteInventory.ps1 -Mode Fixture
```

Live mode uses the Microsoft Graph Sites module. No tenant data is stored in the repository.