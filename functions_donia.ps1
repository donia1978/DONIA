function Write-Log($msg) {
    $global:LogBox.AppendText("$(Get-Date -Format HH:mm:ss) - $msg`n")
}

function Test-Frontend {
    Write-Log "Test du frontend..."
    try {
        Invoke-WebRequest "http://localhost:3000" -TimeoutSec 3 | Out-Null
        Write-Log "Frontend OK"
    } catch {
        Write-Log "Frontend KO"
    }
}

function Test-Backend {
    Write-Log "Test du backend..."
    try {
        $r = Invoke-WebRequest "http://localhost:5000/api/health" -TimeoutSec 3
        Write-Log "Backend OK : $($r.Content)"
    } catch {
        Write-Log "Backend KO"
    }
}

function Docker-Control {
    Write-Log "Lancement Docker..."
    docker-compose up -d | Out-Null
    Write-Log "Docker est lancé"
}

function GitPush {
    Write-Log "Push GitHub..."
    git add .
    git commit -m "Sync $(Get-Date -Format yyyy-MM-dd HH:mm)" | Out-Null
    git push origin master | Out-Null
    Write-Log "Push Git réussi"
}

function Fix-All {
    Write-Log "Réparation DONIA..."
    docker-compose down
    docker-compose build
    docker-compose up -d
    Write-Log "Réparation terminée"
}
