-- Tabela de clientes
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(50),
    estado VARCHAR(2)
);

-- Tabela de contas
CREATE TABLE contas (
    id_conta INT PRIMARY KEY,
    tipo_conta VARCHAR(50)
);

-- Tabela de transações financeiras
CREATE TABLE transacoes (
    id_transacao INT PRIMARY KEY,
    id_cliente INT,
    id_conta INT,
    tipo VARCHAR(10), -- Receita ou Despesa
    valor DECIMAL(10,2),
    data_transacao DATE,
    status VARCHAR(20), -- Pago, Pendente
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_conta) REFERENCES contas(id_conta)
);

-- Dados clientes
INSERT INTO clientes VALUES
(1,'Ana Souza','São Paulo','SP'),
(2,'Carlos Lima','Rio de Janeiro','RJ'),
(3,'Mariana Alves','Belo Horizonte','MG'),
(4,'Rafael Costa','Curitiba','PR'),
(5,'Fernanda Rocha','Salvador','BA');

-- Dados contas
INSERT INTO contas VALUES
(1,'Cartão de Crédito'),
(2,'Conta Corrente'),
(3,'Conta Poupança'),
(4,'Dinheiro');

-- Dados transações
INSERT INTO transacoes VALUES
(1,1,1,'Receita',3500,'2024-01-10','Pago'),
(2,1,2,'Despesa',1200,'2024-01-15','Pago'),
(3,2,1,'Despesa',800,'2024-02-01','Pago'),
(4,2,3,'Receita',4200,'2024-02-05','Pago'),
(5,3,2,'Despesa',600,'2024-02-10','Pendente'),
(6,3,4,'Receita',2800,'2024-02-15','Pago'),
(7,4,1,'Despesa',1500,'2024-03-01','Pago'),
(8,4,2,'Receita',1000,'2024-03-03','Pago'),
(9,5,3,'Despesa',900,'2024-03-10','Pendente'),
(10,5,4,'Receita',3100,'2024-03-12','Pago');

SELECT * FROM clientes;
SELECT * FROM contas;
SELECT * FROM transacoes;
/*1 - Liste o nome do cliente, tipo de conta e valor 
de todas as transações realizadas.*/
SELECT c.nome, co.tipo_conta, t.valor FROM transacoes t
INNER JOIN clientes c ON c.id_cliente = t.id_cliente
INNER JOIN contas co ON co.id_conta = t.id_conta;

/*2 - Classifique cada transação como Alta, Média ou Baixa com base no valor*/
SELECT valor, 
CASE 
  WHEN valor < 1000 THEN 'Baixa'
  WHEN valor BETWEEN 1100 AND 2800 THEN 'Média'
  ELSE 'Alta' 
END AS 'Classificacao'
FROM transacoes;
  
/*3 - Liste os clientes que tiveram transações entre janeiro e fevereiro de 2024*/
SELECT c.nome, t.data_transacao FROM transacoes t
INNER JOIN clientes c ON c.id_cliente = t.id_cliente
WHERE t.data_transacao BETWEEN '2024-01-01' AND '2024-02-29';

/*4 - Mostre o total movimentado por tipo de conta, do maior para o menor.*/
SELECT co.tipo_conta, SUM(t.valor) AS ValorDasMovimento FROM transacoes t
INNER JOIN contas co ON co.id_conta = t.id_conta
GROUP BY co.tipo_conta ORDER BY SUM(t.valor) DESC;

/*5 - Identifique clientes que possuem transações pendentes.*/
SELECT c.nome, t.status FROM transacoes t
INNER JOIN clientes c ON c.id_cliente = t.id_cliente
WHERE t.status = 'Pendente';

/*6 - Mostre clientes que tiveram receitas acima da média geral.*/
SELECT c.nome, SUM(t.valor) AS AcimaDaMedia FROM transacoes t
INNER JOIN clientes c ON c.id_cliente = t.id_cliente
GROUP BY c.nome HAVING SUM(t.valor) > (
SELECT AVG(valor) FROM transacoes);

/*7 - Exiba as transações realizadas em contas específicas 
(ex: Cartão e Conta Corrente).*/
SELECT co.tipo_conta, SUM(t.valor) AS ContasEspecificas FROM transacoes t
INNER JOIN contas co ON co.id_conta = t.id_conta
WHERE co.tipo_conta IN ('Conta Corrente','Dinheiro')
GROUP BY co.tipo_conta;





