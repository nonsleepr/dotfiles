Import-Module posh-git
Import-Module z

Invoke-Expression (oh-my-posh --init --shell pwsh --config "$Env:LocalAppData/Programs/oh-my-posh/themes/pure.omp.json")
#Import-Module oh-my-posh
#Set-PoshPrompt -Theme pure

# Fix Solarized Dark colors in Windows Terminal
Set-PSReadLineOption -Colors @{"Parameter" = [ConsoleColor]::Blue}
Set-PSReadLineOption -Colors @{"Operator" = [ConsoleColor]::White}

# File highlighting
$PSStyle.FileInfo.Directory = $PSStyle.Foreground.Blue
$PSStyle.FileInfo.SymbolicLink = $PSStyle.Italic + $PSStyle.Foreground.Blue + $PSStyle.Background.DarkGray
$PSStyle.FileInfo.Executable = $PSStyle.Foreground.Green
$PSStyle.FileInfo.Extension.Add(".py", $PSStyle.Foreground.Green)
$PSStyle.FileInfo.Extension.Add(".rb", $PSStyle.Foreground.Green)
$PSStyle.FileInfo.Extension.Add(".sh", $PSStyle.Foreground.Green)


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

If ($IsWindows) {
  $Env:COURSIER_HOME = $Env:AppData.Replace("\", "/") + "/Coursier"
}
