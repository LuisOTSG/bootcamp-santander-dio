-- Aula 1 - Normalização de Dados

-- Normalizar a tabela 'usuarios' de acordo com a 1FN

-- Adicionar as colunas de rua, numero, bairro, cidade, estado
ALTER TABLE usuarios
ADD rua VARCHAR(100),
ADD numero VARCHAR(20),
ADD bairro VARCHAR(100)
ADD cidade VARCHAR(100),
ADD estado VARCHAR(50);

-- Fazer a divisão do texto na coluna 'endereco' e adicionar às novas colunas
UPDATE usuarios
SET
	rua = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(endereco, ',', 1), ',', -1)),W
	numero = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(endereco, '-', 1), ',', -1)),
	bairro = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(endereco, ',', 2), '-', -1)),
	cidade = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(endereco, '/', 1), ',', -1)),
	estado = TRIM(SUBSTRING_INDEX(endereco, '/', -1));

-- Excluir a coluna 'endereco'
ALTER TABLE usuarios
DROP COLUMN endereco;