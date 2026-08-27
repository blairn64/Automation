# Azure Resource Inventory

A small Azure CLI/PowerShell lab exercise for producing a reviewable inventory of resources in an authorized subscription.

## Learning objective

Demonstrate resource discovery, structured output and safe reporting without embedding subscription or tenant identifiers in source control.

## PowerShell example

```powershell
# Authenticate separately in your lab.
az login
az account set --subscription "YOUR-SUBSCRIPTION-ID"
az resource list --query "[].{name:name,type:type,resourceGroup:resourceGroup,location:location}" -o table
```

## Notes

The repository uses placeholders only. Never commit a real subscription ID, tenant ID, private endpoint or credential.
