Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme pure

# Fix Solarized Dark colors in Windows Terminal
Set-PSReadLineOption -Colors @{"Parameter" = [ConsoleColor]::Blue}
Set-PSReadLineOption -Colors @{"Operator" = [ConsoleColor]::White}

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -PredictionSource History

# Store previous command's output in $__
$PSDefaultParameterValues['Out-Default:OutVariable'] = '__'


$Env:FZF_DEFAULT_COMMAND = 'ag -g ""'

$Env:Path += ";$Env:USERPROFILE\bin"

# === Neovim
function Start-Neovim {
  nvim $args
}

New-Alias vi Start-Neovim