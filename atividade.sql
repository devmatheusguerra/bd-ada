CREATE TABLE IF NOT EXISTS agencia(
    codAgencia SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL    
);

CREATE TABLE IF NOT EXISTS cliente(
    codCliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    rua VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS emprestimo(
    nroEmprestimo SERIAL PRIMARY KEY,
    codAgencia INT NOT NULL,
    rua VARCHAR(50) NOT NULL,
    total REAL NOT NULL,
    
    CONSTRAINT FK_AgenciaEmp FOREIGN KEY (codAgencia) REFERENCES agencia(codAgencia)
);

CREATE TABLE IF NOT EXISTS devedor(
    codCliente INT NOT NULL,
    nroEmprestimo INT NOT NULL,
    
    PRIMARY KEY(codCliente, nroEmprestimo),
    
    CONSTRAINT FK_ClienteDevedor FOREIGN KEY (codCliente) REFERENCES cliente(codCliente),
    CONSTRAINT FK_EmprestimoDevedor FOREIGN KEY (nroEmprestimo) REFERENCES emprestimo(nroEmprestimo)
    
);


CREATE TABLE IF NOT EXISTS conta (
    nroConta SERIAL PRIMARY KEY,
    codAgencia INT NOT NULL,
    saldo REAL NOT NULL DEFAULT 0,
    
    CONSTRAINT FK_AgenciaConta FOREIGN KEY (codAgencia) REFERENCES agencia(codAgencia)
);

CREATE TABLE IF NOT EXISTS correntista (
    codAgencia INT NOT NULL,
    nroConta INT NOT NULL,
    
    PRIMARY KEY(codAgencia, nroConta),
    
    
    CONSTRAINT FK_AgenciaCorrentista FOREIGN KEY (codAgencia) REFERENCES agencia(codAgencia),
    CONSTRAINT FK_ContaCorrentista FOREIGN KEY (nroConta) REFERENCES conta(nroConta)
);



-- Inserções
INSERT INTO agencia (nome, cidade) VALUES ('Agência 1', 'Cidade 1');
INSERT INTO agencia (nome, cidade) VALUES ('Agência 2', 'Cidade 2');

INSERT INTO cliente (nome, rua, cidade) VALUES ('Cliente 1', 'Rua 1', 'Cidade 1');
INSERT INTO cliente (nome, rua, cidade) VALUES ('Cliente 2', 'Rua 2', 'Cidade 1');
INSERT INTO cliente (nome, rua, cidade) VALUES ('Cliente 3', 'Rua 1', 'Cidade 2');

INSERT INTO emprestimo (codAgencia, rua, total) VALUES (1, 'Rua 1', 1000);
INSERT INTO emprestimo (codAgencia, rua, total) VALUES (1, 'Rua 2', 2000);
INSERT INTO emprestimo (codAgencia, rua, total) VALUES (2, 'Rua 1', 3000);

INSERT INTO devedor (codCliente, nroEmprestimo) VALUES (1, 1);
INSERT INTO devedor (codCliente, nroEmprestimo) VALUES (2, 2);
INSERT INTO devedor (codCliente, nroEmprestimo) VALUES (3, 3);

INSERT INTO conta (codAgencia) VALUES (1);
INSERT INTO conta (codAgencia, saldo) VALUES (1, 2000);
INSERT INTO conta (codAgencia, saldo) VALUES (2, 3000);

INSERT INTO correntista (codAgencia, nroConta) VALUES (1, 1);
INSERT INTO correntista (codAgencia, nroConta) VALUES (1, 2);
INSERT INTO correntista (codAgencia, nroConta) VALUES (2, 3);


-- Item A
-- Listar as informações dos empréstimos com totais superiores a R$ 1200,00.
SELECT * FROM emprestimo WHERE total > 1200;


-- Item B
-- Listar o número dos empréstimos com totais superiores a R$ 1200,00.
SELECT nroEmprestimo FROM emprestimo WHERE total > 1200;

-- Item C
-- Listar os nome dos clientes que possuem empréstimos na agência 1.
SELECT c.nome FROM cliente c, emprestimo e, devedor d, agencia a WHERE a = 'Agência 1'

