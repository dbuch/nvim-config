@echo off

echo Checking for Rustup...

rustup --version >nul 2>nul
if %errorlevel% neq 0 (
    echo Rustup is not installed, installing...
    start /wait "" "https://win.rustup.rs/x86_64"
    set "RUSTUP_HOME=%USERPROFILE%\.rustup"
    set "CARGO_HOME=%USERPROFILE%\.cargo"
    set "PATH=%PATH%;%CARGO_HOME%\bin"
) else (
    echo Already installed rustup
)

echo Installing or updating winget applications...

set "winget_packages=neovim neovim.nightly git llvm.9 nushell"
set "cargo_installs=ripgrep fd"

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

echo Installing cargo applications...

for %%P in (%cargo_installs%) do (
    set "package=%%P"
    echo Checking for %package%...
    cargo install --list | findstr /i "\<%package%\>" >nul
    if %errorlevel% equ 0 (
        echo %package% is already installed, skipping...
    ) else (
        echo Installing %package%...
        cargo install %package%
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
