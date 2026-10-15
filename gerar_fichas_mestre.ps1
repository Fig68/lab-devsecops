param(
    [string]$NomeExpedicao = "Mirante_Teresa_dos_Cabritos",
    [string]$DataOperacao = "2026-10-20",
    [string]$Cliente = "Grupo Eclético / B2B",
    [int]$Participantes = 5, [string]$Responsavel = "Marcelo de Figueiredo"
)

Write-Host "=== Gerador Mestre de Fichas Operacionais | Maria Comprida ===" -ForegroundColor Cyan

$pastaProduto = Join-Path $PSScriptRoot $NomeExpedicao

if (!(Test-Path $pastaProduto)) {
    New-Item -ItemType Directory -Path $pastaProduto | Out-Null
}

$cabecalhoMestre = @"
==================================================
MARIA COMPRIDA MONTANHISMO - FICHA OPERACIONAL UNIFICADA
==================================================
Expedição/Produto: $NomeExpedicao
Data da Operação: $DataOperacao
Cliente/Agência:  $Cliente
Nº Participantes: $Participantes
Responsável Técnico: $Responsavel
CNPJ: 63.245.994/0001-26 | Cadastur: 19.914341.35-3
==================================================
"@

$fops = @{
    "01-Propostas-e-Contratos\FOP-01_Ficha_Operacional.txt" = "--- FOP-01: Ficha Operacional de Serviço ---"
    "02-Checklists-Operacionais\FOP-02_Checklist_PreOperacao.txt" = "--- FOP-02: Checklist de Pré-Operação (D-7/D-1) ---"
    "03-Controle-Participantes\FOP-03_Controle_Participantes.txt" = "--- FOP-03: Controle de Participantes e Segurança ---"
    "04-Logistica-Fornecedores\FOP-04_Logistica_Fornecedores.txt" = "--- FOP-04: Controle de Logística e Fornecedores ---"
    "05-Relatorios-Pos-Operacao\FOP-05_Relatorio_PosOperacao.txt" = "--- FOP-05: Relatório Pós-Operação ---"
}

foreach ($caminhoRelativo in $fops.Keys) {
  $subTitulo = $fops[$caminhoRelativo]
    $caminhoCompleto = Join-Path $pastaProduto $caminhoRelativo
    
    $pastaPai = Split-Path $caminhoCompleto
    if (!(Test-Path $pastaPai)) {
        New-Item -ItemType Directory -Path $pastaPai | Out-Null
    }

    $conteudoFinal = "$cabecalhoMestre`n`n$subTitulo`n[Status: Preenchido automaticamente pelo sistema central]"
    Set-Content -Path $caminhoCompleto -Value $conteudoFinal
    Write-Host "[ATUALIZADO] $caminhoRelativo" -ForegroundColor Green
}

Write-Host "`nTodas as FOPs foram geradas e sincronizadas a partir da Fonte Única de Verdade!" -ForegroundColor Cyan