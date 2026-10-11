import hashlib

def calcular_sha256(caminho_arquivo):
    sha256_hash = hashlib.sha256()
    try:
        with open(caminho_arquivo, "rb") as f:
            for byte_block in iter(lambda: f.read(4096), b""):
                sha256_hash.update(byte_block)
        return sha256_hash.hexdigest()
    except FileNotFoundError:
        return None

if __name__ == "__main__":
    print("=== Verificador de Integridade SHA-256 (Lab DevSecOps) ===")
    arquivo = input("Digite o caminho do ficheiro que deseja analisar: ").strip()
    arquivo = arquivo.strip('"\'')
    
    hash_resultado = calcular_sha256(arquivo)
    if hash_resultado:
        print(f"\n[SUCESSO] Hash SHA-256 calculado:")
        print(hash_resultado)
    else:
        print(f"\n[ERRO] Ficheiro não encontrado: {arquivo}")