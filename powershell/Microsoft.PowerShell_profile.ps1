Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme pure

# Fix Solarized Dark colors in Windows Terminal
Set-PSReadLineOption -Colors @{"Parameter" = [ConsoleColor]::Blue}
Set-PSReadLineOption -Colors @{"Operator" = [ConsoleColor]::White}

#Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource History -PredictionViewStyle ListView

# This allows me to use Ctrl-x,Ctrl-e to edit the stuff
$Env:EDITOR = "nvim"

# Store previous command's output in $__
$PSDefaultParameterValues['Out-Default:OutVariable'] = '__'


$Env:FZF_DEFAULT_COMMAND = 'ag -g ""'

$Env:Path += ";$Env:USERPROFILE\bin"

# === Neovim ===
function Start-Neovim {
  nvim $args
}

New-Alias vi Start-Neovim

# === Scala ===
$Env:COURSIER_HOME = $Env:AppData.Replace("\", "/") + "/Coursier"
