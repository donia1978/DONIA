Write-Host "=== AUDIT & CLEANUP DU PROJET DONIA 2026 ===" -ForegroundColor Cyan

# Chemin du projet
$Project = "C:\projet 2026"

if (-not (Test-Path $Project)) {
    Write-Host "ERREUR : Chemin du projet introuvable : $Project" -ForegroundColor Red
    exit
}

Write-Host "Projet détecté : $Project" -ForegroundColor Yellow

# ------------------------------
# 1. SUPPRESSION DES DOSSIERS INUTILES
# ------------------------------
$RemoveDirs = @(
    "node_modules",
    ".next",
    "dist",
    "build",
    ".turbo",
    ".cache",
    ".vercel",
    "coverage",
    "tmp",
    "temp"
)

Write-Host "`nNettoyage des dossiers inutiles..." -ForegroundColor Cyan

foreach ($dir in $RemoveDirs) {
    $paths = Get-ChildItem -Path $Project -Recurse -Directory -Force -ErrorAction SilentlyContinue |
             Where-Object { $_.Name -eq $dir }

    foreach ($p in $paths) {
        Write-Host "Suppression dossier : $($p.FullName)" -ForegroundColor DarkYellow
        Remove-Item -Recurse -Force $p.FullName -ErrorAction SilentlyContinue
    }
}

# ------------------------------
# 2. SUPPRESSION DES FICHIERS INUTILES
# ------------------------------
$RemoveFiles = @(
    "*.log",
    "*.tmp",
    "*.temp",
    "*.bak",
    "*.old",
    "*.orig",
    ".DS_Store",
    "Thumbs.db"
)

Write-Host "`nNettoyage des fichiers inutiles..." -ForegroundColor Cyan

foreach ($pattern in $RemoveFiles) {
    $files = Get-ChildItem -Path $Project -Recurse -File -Filter $pattern -Force -ErrorAction SilentlyContinue

    foreach ($file in $files) {
        Write-Host "Suppression fichier : $($file.FullName)" -ForegroundColor DarkYellow
        Remove-Item -Force $file.FullName -ErrorAction SilentlyContinue
    }
}

# ------------------------------
# 3. CREATION / REECRITURE DU .gitignore
# ------------------------------
Write-Host "`nMise à jour du fichier .gitignore..." -ForegroundColor Cyan

$GitIgnoreContent = @"
# === DONIA PROJECT CLEANUP AUTO-GENERATED ===

# Node
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*

# Next.js
.next/
out/
.vercel/

# Build
dist/
build/

# Logs & Temp
*.log
*.tmp
*.temp
*.bak
*.old
*.orig
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/

# System
.env
.env.local
.env.production
.env.development

# Coverage
coverage/
"@

Set-Content -Path "$Project\.gitignore" -Value $GitIgnoreContent -Encoding UTF8
Write-Host ".gitignore mis a jour." -ForegroundColor Green

# ------------------------------
# 4. AUDIT DU PROJET
# ------------------------------
Write-Host "`nAudit du projet..." -ForegroundColor Cyan

$size = (Get-ChildItem -Recurse $Project | Measure-Object -Property length -Sum).Sum / 1MB
Write-Host "Taille totale après nettoyage : $([math]::Round($size,2)) MB" -ForegroundColor Green

# ------------------------------
# 5. PREPARATION GIT
# ------------------------------
Write-Host "`nPréparation Git..." -ForegroundColor Cyan

if (Test-Path "$Project\.git") {
    Write-Host "Repo Git déjà initialisé." -ForegroundColor Green
} else {
    Write-Host "Initialisation d'un nouveau dépôt Git." -ForegroundColor Yellow
    git init $Project
}

Write-Host "`n=== CLEANUP DONIA 2026 TERMINE ===" -ForegroundColor Green
