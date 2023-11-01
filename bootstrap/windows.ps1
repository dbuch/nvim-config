# Get a list of installed packages using winget
$installedPackages = winget list

# List of package names to upgrade
$appArray = @(
  "Microsoft.WindowsTerminal",
  "Neovim.Neovim",
  "Git.Git",
  "LLVM.LLVM",
  "kitware.cmake",
  "Nushell.Nushell",
  "sharkdp.fd",
  "BurntSushi.ripgrep.MSVC",
  "7zip.7zip"
)

foreach ($appName in $appArray) {
    # Check if the package is installed
    $packageInfo = $installedPackages | Where-Object { $_ -match "^$appName\s" }
    
    if ($packageInfo) {
        # Package is installed, upgrade it
        Write-Host "Updating $appName"
        winget upgrade $appName
    } else {
        # Package is not installed
        Write-Host "$appName is not installed."
        winget install $appName
    }
}
