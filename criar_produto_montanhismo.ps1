param(
    [Parameter(Mandatory=$true)]
    [string]$NomeProduto
)

Write-Host "=== Criando Estrutura Operacional: $NomeProduto ===" -ForegroundColor Cyan

# Define o caminho base na pasta atual
$pastaProduto = Join-Path $PSScriptRoot $NomeProduto

# Subpastas padronizadas baseadas no Kit Operacional Maria Comprida
$subpastas = @(
    "01-Propostas-e-Contratos",
    "02-Checklists-Operacionais",
    "03-Controle-Participantes",
    "04-Logistica-Fornecedores",
    "05-Relatorios-Pos-Operacao"
)

# Cria a pasta principal e as subpastas
foreach ($sub in $subpastas) {
    $caminhoCompleto = Join-Path $pastaProduto $sub
    if (!(Test-Path $caminhoCompleto)) {
        New-Item -ItemType Directory -Path $caminhoCompleto | Out-Null
        Write-Host "[CRIADO] $sub" -ForegroundColor Green
    }
}

Write-Host "`nEstrutura pronta para a operação de $NomeProduto com sucesso!" -ForegroundColor Cyan