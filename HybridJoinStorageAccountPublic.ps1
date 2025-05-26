Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser

cd C:\temp\AzFilesHybrid
.\CopyToPSPath.ps1

Import-Module -Name azfileshybrid

Connect-AzAccount 

$SubscriptionId = "Zet hier je subscription ID" # ID van de Subscription waar je storageaccount in zit
$ResourceGroupName = "ResourceGroup Name" # Resource group naam waar je storage account staat
$StorageAccountName = "StorageAccountName" # Naam van je storage account in Azure
$SamAccountName = "ADDS SAM AccountName" # Geef een naam voor je storage account in ADDS
$DomainAccountType = "ComputerAccount" # kan zo blijven staan 
$OuDistinguishedName = "OU to put the storageaccount" # Example OU=Storage Accounts,OU=Pipo,DC=Pipo,DC=nl

Select-AzSubscription -SubscriptionId $SubscriptionId

Join-AzStorageAccount `
        -ResourceGroupName $ResourceGroupName `
        -StorageAccountName $StorageAccountName `
        -SamAccountName $SamAccountName `
        -DomainAccountType $DomainAccountType `
        -OrganizationalUnitDistinguishedName $OuDistinguishedName

Debug-AzStorageAccountAuth -StorageAccountName $StorageAccountName -ResourceGroupName $ResourceGroupName -Verbose

# Get the target storage account
$storageaccount = Get-AzStorageAccount `
        -ResourceGroupName "Resource Group name" `
        -Name "Azure Storage account name"

# List the directory service of the selected service account
$storageAccount.AzureFilesIdentityBasedAuth.DirectoryServiceOptions

# List the directory domain information if the storage account has enabled AD DS authentication for file shares
$storageAccount.AzureFilesIdentityBasedAuth.ActiveDirectoryProperties
