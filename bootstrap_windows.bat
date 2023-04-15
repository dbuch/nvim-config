@echo off

echo Installing or updating winget applications...

set "winget_packages=Microsoft.WindowsTerminal Neovim.Neovim Git.Git LLVM.LLVM Nushell.Nushell sharkdp.fd BurntSushi.ripgrep.MSVC"

set "upgradable="

for %%P in (%winget_packages%) do (
    set "package=%%P"
    echo Checking for %package%...
    winget show %package% >nul 2>nul
    if %errorlevel% equ 0 (
        echo %package% is already installed, checking for updates...
        winget upgrade --no-self-upgrade %package%
        if %errorlevel% equ 0 (
            set "upgradable=%upgradable% %package%"
        )
    ) else (
        echo Installing %package%...
        winget install %package%
    )
)

if defined upgradable (
    echo.
    echo The following packages have updates available: %upgradable%
    set /p "upgrade=Do you want to upgrade them? (y/n) "
    if /i "%upgrade%"=="y" (
        for %%P in (%upgradable%) do (
            echo Upgrading %%P...
            winget upgrade --no-self-upgrade %%P
        )
    ) else (
        echo Skipping upgrades.
    )
) else (
    echo All packages are up to date.
)

echo Done!
