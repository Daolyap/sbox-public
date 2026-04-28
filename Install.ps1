# Install dependencies
winget install Microsoft.DotNet.SDK.10 --accept-source-agreements --accept-package-agreements
winget install Git.Git --accept-source-agreements --accept-package-agreements

# Use git directly by full path
$git = "C:\Program Files\Git\bin\git.exe"

# Clone repo
$installPath = "$env:USERPROFILE\Desktop\sbox"
New-Item -ItemType Directory -Force -Path $installPath
Set-Location $installPath
& $git clone https://github.com/Facepunch/sbox-public.git sbox-source
Set-Location "sbox-source"

# Patch AppID to Spacewar
$appFile = ".\engine\Sandbox.Engine\Application.cs"
(Get-Content $appFile) -replace 'AppId\s*=\s*\d+', 'AppId = 480' | Set-Content $appFile

# Bootstrap
.\Bootstrap.bat

# Open game directory
Invoke-Item ".\game"