-- Aula 1 - Consulta com junções e subconsultas

-- INNER JOIN
SELECT * FROM usuarios us
INNER JOIN reservas res
ON us.id = res.id_usuario;

SELECT * FROM usuarios us
INNER JOIN reservas res
ON us.id = res.id_usuario
INNER JOIN destinos des
ON res.id_destino = des.id;

-- Adicionando usuário sem reservas para exemplos de LEFT JOIN
INSERT INTO usuarios (nome, email, dataNascimento, rua, numero, bairro, cidade, estado) VALUES
('Sem Reservas', 'teste@email.com', '1999-12-25', 'Rua B', '13', 'Janeiro', 'Sete Lagoas', 'MG');

-- LEFT JOIN ou LEFT OUTER JOIN
SELECT * FROM usuarios us
LEFT JOIN reservas res
ON us.id = res.id_usuario;

-- Adicionando destino sem reserva para exemplos de RIGHT JOIN
INSERT INTO destinos (nome, descricao) VALUES
('Sem Reserva', 'Destino sem reserva');

-- RIGHT JOIN ou RIGHT OUTER JOIN
SELECT * FROM reservas res
RIGHT JOIN destinos des
ON res.id = des.id;

-- Subconsultas
-- Destino sem reserva usando subconsulta
SELECT * FROM destinos
WHERE id NOT IN (SELECT id_destino FROM reservas);

-- Usuário que não realizou nenhuma reserva com subconsulta
SELECT * FROM usuarios
WHERE id NOT IN (SELECT id_usuario FROM reservas);

-- Subconsulta com função agregada
SELECT nome (SELECT COUNT(*) FROM reservas WHERE id_usuario = usuarios.id) AS total_reservas FROM usuarios;

-- Aula 2 - Funções agregadas e agrupamento de resultados

-- Função agregadora: COUNT
SELECT COUNT(*) FROM usuarios;

--Função agregadora: COUNT nomeando a coluna
SELECT COUNT(*) AS total_usuarios FROM usuarios;

-- Função agregadora: MAX retornar maior idade em anos usando TIMESTAMPDIFF
SELECT MAX(TIMESTAMPDIFF(YEAR, dataNascimento, CURRENT_DATE())) AS maior_idade FROM usuarios;

-- Agrupamento de Resultados: GROUP BY com COUNT para retornar quantidade de reservas por destino
SELECT id_destino, COUNT(*) AS qtde_reservas FROM reservas
GROUP BY id_destino;

-- Ordenação de resultados: ORDER BY para ordenar quantidade de reservas por destino de forma ascendente (menor para o maior)
SELECT id_destino, COUNT(*) AS qtde_reservas FROM reservas
GROUP BY id_destino
ORDER BY qtde_reservas;

-- Aula 03 - Índices

-- EXPLAIN
EXPLAIN
	SELECT * FROM usuarios WHERE id = 1;

-- Criar um índice para a coluna de uma tabela
CREATE INDEX idx_nome ON usuarios (nome);