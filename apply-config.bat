@echo off
setlocal enabledelayedexpansion

REM Déterminer le répertoire du script et le répertoire cible (parent)
set "SCRIPT_DIR=%~dp0"
set "TARGET_DIR=%SCRIPT_DIR%"
set "TARGET_DIR=%TARGET_DIR:~0,-1%"

echo 🔧 Applying OpenCode configuration to: %TARGET_DIR%
echo.

REM Vérifier si opencode.jsonc existe déjà
if exist "%TARGET_DIR%\opencode.jsonc" (
    echo ⚠️  opencode.jsonc existe déjà dans %TARGET_DIR%
    set /p "OVERWRITE=Voulez-vous l'écraser ? (o=oui, n=non, q=quitter): "
    
    if /i "!OVERWRITE!"=="n" (
        echo ⛔ Écrasement refusé. Configuration existante conservée.
        exit /b
    )
    if /i "!OVERWRITE!"=="q" (
        echo ❌ Opération annulée.
        exit /b
    )
)

REM Vérifier si .opencode/ existe déjà
if exist "%TARGET_DIR%.opencode" (
    echo ⚠️  .opencode/ existe déjà dans %TARGET_DIR%
    set /p "OVERWRITE=Voulez-vous l'écraser ? (o=oui, n=non, q=quitter): "
    
    if /i "!OVERWRITE!"=="n" (
        echo ⛔ Écrasement refusé. Configuration existante conservée.
        exit /b
    )
    if /i "!OVERWRITE!"=="q" (
        echo ❌ Opération annulée.
        exit /b
    )
)

echo 📦 Copie des fichiers...

REM Copier opencode.jsonc à la racine
copy "%SCRIPT_DIR%opencode.jsonc" "%TARGET_DIR%\" >nul
echo   ✓ opencode.jsonc

REM Copier .opencode/ en entier
xcopy /E /C /I "%SCRIPT_DIR%.opencode%" "%TARGET_DIR%.opencode\" >nul
echo   ✓ .opencode/

echo.
echo ✅ OpenCode configuration appliquée avec succès !
echo.
echo 🗑️  Nettoyage du dossier temporaire...

REM Supprimer le dossier temporaire (le dossier où le script se trouve)
REM Le script s'exécute depuis .tmp-opencode-config/, on supprime tout
cd /d "%SCRIPT_DIR%"
for /f "delims=" %%i in ('cd') do set "CURRENT_DIR=%%i"
if not "%CURRENT_DIR%"=="" (
    rd /s /q "%CURRENT_DIR%"
)

echo ✅ Dossier temporaire supprimé.
echo.
echo 🎉 Prêt ! Votre OpenCode config est maintenant configuré.
