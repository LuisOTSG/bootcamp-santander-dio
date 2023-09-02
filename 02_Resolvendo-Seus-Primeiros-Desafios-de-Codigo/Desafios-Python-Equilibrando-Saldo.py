saldo_atual = float(input())
valor_deposito = float(input())
valor_retirada = float(input())

# TODO: Calcular o saldo atualizado de acordo com a descrição deste desafio.
saldo_atual = saldo_atual + valor_deposito
saldo_atual = saldo_atual - valor_retirada
# TODO: Imprimir o a saída de conforme a tabela de exemplos (uma casa decimal).
print(f"Saldo atualizado na conta: {saldo_atual}")