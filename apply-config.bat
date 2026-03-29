@echo off
setlocal enabledelayedexpansion

REM Déterminer le répertoire du script et le répertoire cible (parent)
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_PARENT=%~dp0.."

REM Nettoyer les chemins (supprimer le \ final si présent)
if "%SCRIPT_DIR:~-1%"=="\" set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
if "%SCRIPT_PARENT:~-1%"=="\" set "SCRIPT_PARENT=%SCRIPT_PARENT:~0,-1%"

REM Aller dans le dossier parent pour obtenir le chemin absolu
pushd "%SCRIPT_PARENT%" >nul 2>&1
if errorlevel 1 (
    echo ❌ Impossible de déterminer le dossier parent de %SCRIPT_DIR%
    exit /b 1
)
set "TARGET_DIR=%CD%"
popd >nul 2>&1

echo 🔧 Applying OpenCode configuration to: %TARGET_DIR%
echo.

REM Helper function to check and ask for overwrite
set "OVERWRITE_NEEDED="
set "OVERWRITE_ITEM="

REM Vérifier si opencode.jsonc existe déjà
if exist "%TARGET_DIR%\opencode.jsonc" (
    echo ⚠️  opencode.jsonc existe déjà dans %TARGET_DIR%
    set "OVERWRITE_NEEDED=1"
    set "OVERWRITE_ITEM=opencode.jsonc"
)

REM Vérifier si .opencode/ existe déjà
if exist "%TARGET_DIR%\.opencode\" (
    echo ⚠️  .opencode/ existe déjà dans %TARGET_DIR%
    if defined OVERWRITE_NEEDED (
        echo     Attention : les deux éléments existent déjà.
    )
    set "OVERWRITE_NEEDED=1"
    if not defined OVERWRITE_ITEM set "OVERWRITE_ITEM=.opencode/"
)

REM Demander confirmation si nécessaire
if defined OVERWRITE_NEEDED (
    set /p "OVERWRITE=Voulez-vous l'écraser ? (o=oui, n=non, q=quitter): "
    
    if /i "!OVERWRITE!"=="q" (
        echo ❌ Opération annulée.
        exit /b
    )
    
    if /i not "!OVERWRITE!"=="o" (
        echo ⛔ Écrasement refusé. Configuration existante conservée.
        exit /b
    )
    
    REM Supprimer les fichiers existants
    if exist "%TARGET_DIR%\opencode.jsonc" (
        del /Q "%TARGET_DIR%\opencode.jsonc"
        echo   ✗ opencode.jsonc (supprimé)
    )
    if exist "%TARGET_DIR%\.opencode\" (
        rmdir /S /Q "%TARGET_DIR%\.opencode"
        echo   ✗ .opencode/ (supprimé)
    )
)

echo 📦 Copie des fichiers...

REM Copier opencode.jsonc à la racine du projet
copy /Y "%SCRIPT_DIR%opencode.jsonc" "%TARGET_DIR%\" >nul
echo   ✓ opencode.jsonc

REM Copier .opencode/ en entier
xcopy /E /C /I /Y /EXCLUDE:"%SCRIPT_DIR%.gitignore" "%SCRIPT_DIR%.opencode" "%TARGET_DIR%\.opencode\" >nul
if errorlevel 1 (
    REM Si .gitignore n'existe pas, copier sans exclure
    xcopy /E /C /I /Y "%SCRIPT_DIR%.opencode" "%TARGET_DIR%\.opencode\" >nul
)
echo   ✓ .opencode/

REM Copier .qwen/ en entier (config Qwen Code)
if exist "%TARGET_DIR%\.qwen\" (
    rmdir /S /Q "%TARGET_DIR%\.qwen"
)
xcopy /E /C /I /Y "%SCRIPT_DIR%.qwen" "%TARGET_DIR%\.qwen\" >nul
echo   ✓ .qwen/

echo.
echo ✅ OpenCode configuration appliquée avec succès !
echo.

REM Nettoyage du dossier temporaire
echo 🗑️  Nettoyage du dossier temporaire...

REM Se placer dans le dossier cible pour éviter les problèmes de répertoire courant
cd /d "%TARGET_DIR%"

REM Vérifier si on est dans un dossier .tmp-opencode-config
for %%I in ("%SCRIPT_DIR%") do set "SCRIPT_LEAF=%%~nxI"
set "SCRIPT_GRANDPARENT=%SCRIPT_DIR%"

REM Retirer le dernier composant pour obtenir le grand-parent
for %%P in ("%SCRIPT_GRANDPARENT%") do set "SCRIPT_PARENT_DIR=%%~dpP"
if "!SCRIPT_PARENT_DIR:~-1!"=="\" set "SCRIPT_PARENT_DIR=!SCRIPT_PARENT_DIR:~0,-1!"

if /i "!SCRIPT_LEAF!"==".tmp-opencode-config" (
    REM On est dans .tmp-opencode-config, supprimer le dossier parent
    rd /S /Q "!SCRIPT_PARENT_DIR!"
    echo ✅ Dossier temporaire supprimé.
) else (
    echo ℹ️  Le script n'est pas dans un dossier .tmp-opencode-config
    echo    Supprimez manuellement le dossier d'installation si nécessaire.
)

echo.
echo 🎉 Prêt ! Votre OpenCode config est maintenant configurée.
