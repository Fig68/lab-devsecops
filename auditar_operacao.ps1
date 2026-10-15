param(
    [string]$NomeExpedicao = "Mirante_Teresa_dos_Cabritos"
)

Write-Host "=== Auditoria de Compliance Operacional | Maria Comprida Montanhismo ===" -ForegroundColor Cyan
Write-Host "Analisando expedição: $NomeExpedicao" -ForegroundColor Yellow

$diretorioBase = Join-Path $PSScriptRoot $NomeExpedicao

if (!(Test-Path $diretorioBase)) {
    Write-Host "[ERRO CRÍTICO] A pasta da expedição '$NomeExpedicao' não existe!" -ForegroundColor Red
    exit
}

# Fichas Operacionais Obrigatórias (FOP-01 a FOP-05)
$fopsObrigatorios = @(
    "FOP-01_Ficha_Operacional.txt",
    "FOP-02_Checklist_PreOperacao.txt",
    "FOP-03_Controle_Participantes.txt",
    "FOP-04_Logistica_Fornecedores.txt",
    "FOP-05_Relatorio_PosOperacao.txt"
)

$pendencias = 0

foreach ($fop in $fopsObrigatorios) {
    # Procura o ficheiro em toda a estrutura da expedição
    $encontrado = Get-ChildItem -Path $diretorioBase -Recurse -Filter $fop
    
    if ($encontrado) {
        Write-Host "[OK] $fop presente e arquivado." -ForegroundColor Green
    } else {
        Write-Host "[PENDENTE] $fop em falta para liberação da operação!" -ForegroundColor Yellow
        $pendencias++
    }
}

Write-Host "--------------------------------------------------------"
if ($pendencias -eq 0) {
    Write-Host "STATUS: CONFORMIDADE TOTAL (Operação Aprovada para Campo)!" -ForegroundColor Green
} else {
    Write-Host "STATUS: BLOQUEADO - Existem $pendencias pendências operacionais." -ForegroundColor Red
}