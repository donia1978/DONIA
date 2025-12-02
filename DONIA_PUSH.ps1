# ================================
#  DONIA_PUSH.ps1 – Version PRO
# ================================

Write-Host "=== PUSH DONIA vers GitHub ==="

# --- Chemin du projet ---
$ProjectPath = "C:\projet 2026"

if (-not (Test-Path $ProjectPath)) {
    Write-Host "ERREUR : Le dossier spécifié n'existe pas."
    exit
}

Set-Location $ProjectPath
Write-Host "Projet local : $ProjectPath"

# --- Nettoyage de l'ancien Git ---
if (Test-Path ".git") {
    Write-Host "Suppression de l'ancien dossier .git..."
    Remove-Item -Recurse -Force ".git"
}

# --- Initialisation Git ---
Write-Host "Initialisation d'un nouveau dépôt Git..."
git init

# --- Ajout des fichiers ---
Write-Host "Ajout des fichiers..."
git add .

# --- Commit initial ---
Write-Host "Commit initial..."
git commit -m "PUSH DONIA Projet 2026 - Initialisation propre"

# --- Connexion au dépôt GitHub ---
Write-Host "Connexion au dépôt GitHub DONIA..."
git remote add origin "https://github.com/donia1978/DONIA.git"

# --- Forcer branche main ---
git branch -M main

# --- PUSH forcé ---
Write-Host "Envoi vers GitHub (push --force)..."
git push -u origin main --force

Write-Host "PUSH DONIA TERMINÉ AVEC SUCCÈS."
Write-Host "Dépôt GitHub : https://github.com/donia1978/DONIA"
