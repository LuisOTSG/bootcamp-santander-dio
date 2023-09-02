-- Aula 1 - Tabelas, Colunas e Registros

-- Criar tabela 'usuarios'
CREATE TABLE usuarios (
  id INT,
  nome VARCHAR(255) NOT NULL COMMENT 'Nome do usuário',
  email VARCHAR(255) NOT NULL UNIQUE COMMENT 'Endereço de e-mail do usuário',
  dataNascimento DATE NOT NULL COMMENT 'Data de nascimento do usuário',
  endereco VARCHAR(50) NOT NULL COMMENT 'Endereço do Cliente'
);

-- Criar tabela 'destinos'
CREATE TABLE destinos (
  id INT,
  nome VARCHAR(255) NOT NULL UNIQUE COMMENT 'Nome do destino',
  descricao VARCHAR(255) NOT NULL COMMENT 'Descrição do destino'
);

-- Criar tabela 'reservas'
CREATE TABLE reservas (
  id INT COMMENT 'Identificador único da reserva',
  id_usuario INT COMMENT 'Referência ao ID do usuário que fez a reserva',
  id_destino INT COMMENT 'Referência ao ID do destino da reserva',
  data DATE COMMENT 'Data da reserva',
  status VARCHAR(255) DEFAULT 'Pendente' COMMENT 'Status da reserva (Confirmada, Pendente, Cancelada)'
);

-- Aula 2 - Operações CRUD: Insert e Select

-- Inserir dados na tabela 'usuarios'
INSERT INTO usuarios (id, nome, email, dataNascimento, endereco) VALUES
(1, 'Luis', 'luis@example.com', '1998-01-01', 'Rua A, 123 - Setembro, Sete Lagoas/MG');
(2, 'João Silva', 'joao@example.com', '1990-05-15', 'Rua A, 123 - Outubro, Sete Lagoas/MG'),
(3, 'Maria Santos', 'maria@example.com', '1985-08-22', 'Rua ABC, 321 - Novembro, Sete Lagoas/MG'),
(4, 'Pedro Souza', 'pedro@example.com', '1998-02-10', 'Rua BC, 21 - Dezembro, Sete Lagoas/MG');

-- Inserir dados na tabela 'destinos'
INSERT INTO destinos (id, nome, descricao) VALUES 
(1, 'Gruta Rei do Mato', 'Ponto turístico'),
(2, 'Praia das Tartarugas', 'Uma bela praia com areias brancas e mar cristalino'),
(3, 'Cachoeira do Vale Verde', 'Uma cachoeira exuberante cercada por natureza'),
(4, 'Cidade Histórica de Pedra Alta', 'Uma cidade rica em história e arquitetura');

-- Inserir dados na tabela 'reservas'
INSERT INTO reservas (id, id_usuario, id_destino, data, status) VALUES 
(1, 1, 1, '2023-03-01', 'Confirmada'),
(2, 1, 2, '2023-07-10', 'Confirmada'),
(3, 2, 1, '2023-08-05', 'Pendente'),
(4, 3, 3, '2023-09-20', 'Cancelada');

-- Retornar tabela 'usuarios'
SELECT * FROM usuarios;

-- Retornar tabela 'destinos'
SELECT * FROM destinos;

-- Retornar tabela 'reservas'
SELECT * FROM reservas;

-- Aula 3 - Operações CRUD: Update e Delete7

-- Update e-mails de 'exemplo' para 'email'
UPDATE usuarios
SET email = 'luis@email.com' WHERE id = 1;
UPDATE usuarios
SET email = 'joao@email.com' WHERE id = 2;
UPDATE usuarios
SET email = 'maria@email.com' WHERE id = 3;
UPDATE usuarios
SET email = 'pedro@email.com' WHERE id = 4;

-- Delete reserva onde 'status' é 'Cancelada'
DELETE FROM reservas WHERE status = 'Cancelada';

-- Aula 4 - Alterando e Excluindo Tabelas

-- Opção 1: Criar nova tabela com tamanho de campo modificado e migrar dados

-- Criar nova tabela
CREATE TABLE usuarios_nova (
  id INT,
  nome VARCHAR(255) NOT NULL COMMENT 'Nome do usuário',
  email VARCHAR(255) NOT NULL UNIQUE COMMENT 'Endereço de e-mail do usuário',
  dataNascimento DATE NOT NULL COMMENT 'Data de nascimento do usuário',
  endereco VARCHAR(100) NOT NULL COMMENT 'Endereço do Cliente'
);

-- Migrar dados
INSERT INTO usuarios_nova
SELECT * from usuarios;

-- Excluir tabela anterior
DROP TABLE usuarios;

-- Renomer nova tabela
ALTER TABLE usuarios_nova RENAME usuarios;

-- Opção 2 (mais simples): Alteração do tamanho da coluna 'endereco'
ALTER TABLE usuarios MODIFY COLUMN endereco VARCHAR(100);

-- Chaves Primárias e Estrangeiras

-- Adicionar Primary Key

-- Na tabela 'usuarios'
ALTER TABLE usuarios
MODIFY COLUMN id INT AUTO_INCREMENT,
ADD PRIMARY KEY (id);

-- Na tabela 'destinos'
ALTER TABLE destinos
MODIFY COLUMN id INT AUTO_INCREMENT,
ADD PRIMARY KEY (id);

-- Na tabela 'reservas'
ALTER TABLE reservas
MODIFY COLUMN id INT AUTO_INCREMENT,
ADD PRIMARY KEY (id);

-- Adicionar Foreing Key

-- Na tabela 'reservas' referenciando a tabela 'usuarios'
ALTER TABLE reservas
ADD CONSTRAINT fk_reservas_usuarios
FOREIGN KEY (id_usuario) REFERENCES usuarios(id);

-- Na tabela 'reservas' referenciando a tabela 'destinos'
ALTER TABLE reservas
ADD CONSTRAINT fk_reservas_destinos
FOREIGN KEY (id_destino) REFERENCES destinos(id);