# Define an array of apps to install or update

$appArray = @(
  "Microsoft.WindowsTerminal",
  "Neovim.Neovim",
  "Git.Git",
  "LLVM.LLVM",
  "Nushell.Nushell",
  "sharkdp.fd",
  "BurntSushi.ripgrep.MSVC",
  "7zip.7zip"
)

# Loop through each app in the array
foreach ($app in $appArray) {
    # Check if the app is already installed
    if (winget list -e | Select-String $app) {
        # If the app is already installed, check for updates
        $updateInfo = winget show $app
        if ($updateInfo.versions[0].version -gt (Get-AppxPackage $app).Version) {
            # If a newer version is available, prompt the user to update
            Write-Host "A newer version of $app is available. Do you want to update? (Y/N)"
            $input = Read-Host
            if ($input -eq "Y" -or $input -eq "y") {
                winget upgrade $app
            }
        } else {
            # If the app is already up to date, skip it
            Write-Host "$app is already up to date."
        }
    } else {
        # If the app is not installed, install it
        winget install $app
    }
}
