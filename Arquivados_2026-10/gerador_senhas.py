import string
import secrets

def gerar_senha(tamanho=16):
    # Define o conjunto de caracteres: letras maiúsculas, minúsculas, números e símbolos
    alfabeto = string.ascii_letters + string.digits + string.punctuation
    
    # Usa o módulo 'secrets' para seleção criptograficamente segura
    senha = ''.join(secrets.choice(alfabeto) for _ in range(tamanho))
    return senha

if __name__ == "__main__":
    print("=== Gerador de Senhas Seguras (Lab DevSecOps) ===")
    try:
        tamanho = int(input("Digite o tamanho desejado para a senha (ex: 16): "))
        if tamanho < 8:
            print("Aviso: Recomenda-se um mínimo de 8 caracteres para uma boa segurança.")
        print(f"\nSenha gerada com segurança: {gerar_senha(tamanho)}")
    except ValueError:
        print("Por favor, digite um número inteiro válido.")