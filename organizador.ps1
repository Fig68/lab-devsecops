Write-Host "=== Organizador Inteligente com Proteção de Código (Lab DevSecOps) ===" -ForegroundColor Cyan

$diretorioBase = $PSScriptRoot
$ficheiros = Get-ChildItem -Path $diretorioBase -File

# Lista de ficheiros protegidos que NUNCA devem ser movidos
$ficheirosProtegidos = @("organizador.ps1", "gerador_senhas.py", "verificador_hash.py", ".gitignore")

foreach ($f in $ficheiros) {
    # Verifica se o ficheiro está na lista de protegidos
    if ($ficheirosProtegidos -contains $f.Name) {
        Write-Host "[PROTEGIDO] Ignorando ficheiro principal: $($f.Name)" -ForegroundColor DarkGray
        continue
    }

    # Classificação por Data (Ano-Mês de modificação)
    $anoMes = $f.LastWriteTime.ToString("yyyy-MM")
    $pastaDestino = Join-Path $diretorioBase "Arquivados_$anoMes"

    if (!(Test-Path $pastaDestino)) {
        New-Item -ItemType Directory -Path $pastaDestino | Out-Null
        Write-Host "[NOVA PASTA] $anoMes" -ForegroundColor Yellow
    }

    $caminhoFinal = Join-Path $pastaDestino $f.Name

    # Verificação de Repetições
    if (Test-Path $caminhoFinal) {
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $nomeBase = [System.IO.Path]::GetFileNameWithoutExtension($f.Name)
        $extensao = $f.Extension
        $novoNome = "${nomeBase}_${timestamp}${extensao}"
        $caminhoFinal = Join-Path $pastaDestino $novoNome
        Write-Host "[DUPLICADO] Renomeado para: $novoNome" -ForegroundColor Magenta
    }

    # Movimentação apenas de ficheiros não protegidos
    Move-Item -Path $f.FullName -Destination $caminhoFinal -Force
    Write-Host "[ARQUIVADO] $($f.Name) ---> $anoMes" -ForegroundColor Green
}

Write-Host "`nOrganização concluída com segurança!" -ForegroundColor Cyan