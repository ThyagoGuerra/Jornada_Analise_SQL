-- CRIAÇÃO DAS TABELAS
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    cidade VARCHAR(50),
    estado CHAR(2),
    ativo BOOLEAN
);

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    produto VARCHAR(100),
    preco DECIMAL(10,2),
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE vendas (
    id_venda INT PRIMARY KEY,
    id_cliente INT,
    id_produto INT,
    quantidade INT,
    data_venda DATE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto)
);


-- INSERTS
INSERT INTO clientes VALUES
(1,'Ana Souza','São Paulo','SP',TRUE),
(2,'Carlos Lima','Rio de Janeiro','RJ',TRUE),
(3,'Marcos Silva','Belo Horizonte','MG',TRUE),
(4,'Juliana Costa','Curitiba','PR',FALSE),
(5,'Fernanda Rocha','Salvador','BA',TRUE),
(6,'Paulo Mendes','Fortaleza','CE',TRUE),
(7,'Rafael Nunes','Recife','PE',TRUE),
(8,'Camila Pires','Campinas','SP',FALSE);

INSERT INTO produtos VALUES
(1,'Notebook',4500.00,1),
(2,'Mouse',80.00,3),
(3,'Teclado',150.00,3),
(4,'Monitor',1200.00,1),
(5,'Cadeira Escritório',900.00,2),
(6,'Mesa Escritório',1300.00,2);

INSERT INTO vendas VALUES
(1,1,1,1,'2024-01-10'),
(2,1,2,2,'2024-01-15'),
(3,2,4,1,'2024-02-05'),
(4,3,5,1,'2024-02-10'),
(5,3,6,1,'2024-03-01'),
(6,5,1,1,'2024-03-12'),
(7,6,3,3,'2024-04-02'),
(8,7,2,1,'2024-04-18'),
(9,7,4,2,'2024-05-05'),
(10,2,6,1,'2024-05-20');


/*Listagem de clientes ativos
Liste o nome, cidade e estado de todos os clientes ativos ordenados por nome.*/
SELECT nome, cidade, estado FROM clientes
WHERE ativo = 1;

/*Produtos acima da média de preço
Liste produtos cujo preço seja maior que a média geral dos produtos.*/
SELECT produto, preco FROM produtos WHERE preco > (
SELECT AVG(preco) FROM produtos);

/*Faturamento por cliente
Calcule o total gasto por cada cliente e ordene do maior para o menor.*/
SELECT c.nome, SUM(p.preco * v.quantidade) AS TotalFaturado FROM vendas v
INNER JOIN clientes c ON c.id_cliente = v.id_cliente
INNER JOIN produtos p ON p.id_produto = v.id_produto
GROUP BY c.nome ORDER BY SUM(p.preco * v.quantidade) DESC;










