# TODO: the following only works on symlinked scripts
#$scriptRoot = Split-Path -Parent (Get-Item $PSCommandPath | Select-Object -ExpandProperty Target)
$scriptRoot = Get-Item $PSCommandPath | % DirectoryName
$dotfilesRoot = Split-Path -Parent $scriptRoot

# Symlink Powershell profile
#New-Item -Path $Profile -ItemType SymbolicLink -Value $scriptRoot\Microsoft.PowerShell_profile.ps1

# Symlink Windows Terminal settings
# TODO: Copy the settings to the dotfiles
#New-Item -Path $Env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal*\LocalState\settings.json -ItemType SymbolicLink `
#   -Value $scriptRoot\..\Microsoft.WindowsTerminal\settings.json

# Git Ignore
New-Item -Path $Env:UserProfile\.gitignore -ItemType SymbolicLink -Value $dotfilesRoot\git\gitignore.symlink

# Neovim config
New-Item -Path $Env:LocalAppData\nvim -ItemType SymbolicLink -Value $dotfilesRoot\neovim\config-nvim
