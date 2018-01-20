---
layout: post
---
Unlike the command prompt (CMD.EXE) commandlets in PowerShell do not run in the current directory
as you might expect.
Using CD to move between directories doesn't change the current directory where commandlets are executed.
Using CD and DIR or LS can give you the impression that PowerShell is the same as the command prompt.

```powershell
PS C:\Users\user_name> cd .\Documents
PS C:\Users\user_name\Documents> dir *.json

    Directory: C:\Users\user_name\Documents
    
Mode                LastWriteTime         Length Name 
----                -------------         ------ ----
-a----       20/01/2018     17:44             35 file.json
```

Normal file manipulations appear to work, until you need to provide a path to a commandlet.
Then you have to go back to the current directory where the commandlet is running.

```powershell
PS C:\Users\user_name\Documents> Import-AzureRmContext -Path .\file.json
Import-AzureRmContext : Cannot find file '.\file.json'
At line:1 char:1
+ Import-AzureRmContext -Path .\file.json
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : CloseError: (:) [Import-AzureRmContext], PSArgumentException
    + FullyQualifiedErrorId : Microsoft.Azure.Commands.Profile.ImportAzureRMContextCommand

PS C:\Users\user_name\Documents>[Environment]::CurrentDirectory
C:\Users\user_name

PS C:\Users\user_name\Documents> Import-AzureRmContext -Path .\Documents\file.json

Account          : user_name@domain.com
SubscriptionName : Company Name
SubscriptionId   : ca66b2d5-5e67-4148-92f8-f505f5fc7745
TenantId         : de9c3404-9164-4c27-add5-4b2d43417489
Environment      : AzureStuff

```
Within a script that you might be running you can Get-Item -path.

```powershell
Import-AzureRmContext -Path (Get-Item -Path './develop-joe-context.json' -Verbose).FullName
```

This behaviour seems unintuitive and inconsistent with every other shell-scripting systems,
but does make some sense.
PowerShell allows you to treat the registry like the file system
and having a commandlet run within the registry doesn't make sense.
Also it provides an additional layer of security since the commandlets run from a known location,
so it is harder to spoof a commandlet using a script in the directory.