import secrets
import string

print("=== Gerador de Senhas DevSecOps ===")

# Junta letras (maiúsculas e minúsculas), números e símbolos
caracteres = string.ascii_letters + string.digits + string.punctuation

# O módulo 'secrets' gera senhas imprevisíveis recomendadas para segurança
senha_forte = ''.join(secrets.choice(caracteres) for i in range(16))

print(f"Senha Gerada (16 caracteres): {senha_forte}")
print("===================================")