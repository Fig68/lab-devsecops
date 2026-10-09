import hashlib

print("=== Verificador de Integridade DevSecOps ===")

# Abrindo o PDF original da proposta para leitura binária ("rb")
with open("MARIA COMPRIDA proposta Guido aditivo1.pdf", "rb") as arquivo:
    conteudo = arquivo.read()
    
# Calculando a impressão digital com o algoritmo seguro SHA-256
hash_calculado = hashlib.sha256(conteudo).hexdigest()

print(f"Arquivo analisado: MARIA COMPRIDA proposta Guido aditivo1.pdf")
print(f"Hash SHA-256 gerado: {hash_calculado}")
print("============================================")