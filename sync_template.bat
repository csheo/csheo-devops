@echo off
rem run this script with the following command: .\sync_template.bat %template_repository_url?%
rem template_repository_url is optional, you must provide it at first run
set "template_repository_url=%1"

git remote get-url template >nul 2>&1
if %errorlevel% neq 0 (
  if not "%template_repository_url%"=="" (
    git remote add template %template_repository_url%
  )
)

git fetch template main

git show-ref --quiet refs/heads/sync
if %errorlevel% equ 0 (
  git checkout sync
) else (
  git checkout -b sync
)

git merge template/main
git push origin sync