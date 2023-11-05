$dependencyApps = @(
  "Microsoft.WindowsTerminal",
  "Neovim.Neovim",
  "Git.Git",
  "LLVM.LLVM",
  "kitware.cmake",
  "Nushell.Nushell",
  "sharkdp.fd",
  "BurntSushi.ripgrep.MSVC",
  "7zip.7zip",
  "chmln.sd",
  "Casey.Just",
)

# Get a list of installed packages using winget
$installedPackages = winget list
foreach ($appName in $dependencyApps) {
    $packageInfo = $installedPackages | Where-Object { $_ -match "^$appName\s" }
    
    if ($packageInfo) {
        Write-Host "Updating dependency: $appName"
        winget upgrade $appName > $null
    } else {
        Write-Host "Installing missing:  $appName"
        winget install $appName > $null
    }
}
