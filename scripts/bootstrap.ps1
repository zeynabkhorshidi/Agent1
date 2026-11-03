$ErrorActionPreference = 'Stop'
Set-Location (Split-Path $PSScriptRoot -Parent)
docker info | Out-Null
if ($LASTEXITCODE -ne 0) { throw 'Docker Desktop را با WSL2 و Linux containers راه‌اندازی کنید.' }
if (!(Test-Path '.env')) {
 Copy-Item '.env.example' '.env'
 $bytes=New-Object byte[] 24
 [System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($bytes)
 Add-Content '.env' ("`nDB_PASSWORD=" + ([BitConverter]::ToString($bytes).Replace('-','').ToLower()))
}
docker compose build api
if ($LASTEXITCODE -ne 0) { throw 'ساخت image ناموفق بود؛ خروجی build را بررسی کنید.' }
docker compose up -d --no-build --wait api worker web
if ($LASTEXITCODE -ne 0) { throw 'راه‌اندازی ناموفق بود؛ docker compose logs را بررسی کنید.' }
Write-Host 'حساب بسازید: docker compose exec api python -m packages.domain.seed --user admin'
