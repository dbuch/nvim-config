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

foreach ($app in $appArray) {
    if (winget list -e | Select-String $app) {
        $updateInfo = winget show $app
        if ($updateInfo.versions[0].version -gt (Get-AppxPackage $app).Version) {
            Write-Host "A newer version of $app is available. Do you want to update? (Y/N)"
            $input = Read-Host
            if ($input -eq "Y" -or $input -eq "y") {
                winget upgrade $app
            }
        } else {
            Write-Host "$app is already up to date."
        }
    } else {
        winget install $app
    }
}
