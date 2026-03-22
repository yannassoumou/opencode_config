@echo off
setlocal enabledelayedexpansion

REM Répertoire du script (avec \ final) et répertoire cible = parent (projet à configurer)
set "SCRIPT_DIR=%~dp0"
set "SCRIPT_FOLDER=%SCRIPT_DIR:~0,-1%"
pushd "%SCRIPT_DIR%.." >nul 2>&1
if errorlevel 1 (
    echo ❌ Impossible de déterminer le dossier parent de %SCRIPT_DIR%
    exit /b 1
)
set "TARGET_DIR=%CD%"
popd >nul 2>&1

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
if exist "%TARGET_DIR%\.opencode\" (
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

REM Copier opencode.jsonc à la racine du projet
copy /Y "%SCRIPT_DIR%opencode.jsonc" "%TARGET_DIR%\" >nul
echo   ✓ opencode.jsonc

REM Copier .opencode/ en entier (chemin explicite avec \ avant .opencode)
xcopy /E /C /I /Y "%SCRIPT_DIR%.opencode" "%TARGET_DIR%\.opencode\" >nul
echo   ✓ .opencode/

echo.
echo ✅ OpenCode configuration appliquée avec succès !
echo.
echo 🗑️  Nettoyage du dossier temporaire...

REM Ne jamais supprimer le répertoire courant : cd vers le projet, puis rd sur le dossier du script uniquement
cd /d "%TARGET_DIR%"
if errorlevel 1 (
    echo ⚠️  Impossible de se placer dans %TARGET_DIR% — nettoyage manuel du dossier temporaire peut être nécessaire.
    exit /b 1
)

for %%I in ("%SCRIPT_FOLDER%") do set "SCRIPT_LEAF=%%~nxI"
if /i not "%SCRIPT_LEAF%"==".tmp-opencode-config" (
    echo ⚠️  Suppression auto désactivée : le script n'est pas dans un dossier nommé .tmp-opencode-config
    echo     ^(dossier actuel : %SCRIPT_FOLDER%^). Supprimez ce dossier à la main si c'était une copie temporaire.
    goto :after_cleanup
)

rd /s /q "%SCRIPT_FOLDER%"
echo ✅ Dossier temporaire supprimé.

:after_cleanup
echo.
echo 🎉 Prêt ! Votre OpenCode config est maintenant configuré.
