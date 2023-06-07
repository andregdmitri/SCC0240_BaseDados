-- Tabela Administrador
CREATE TABLE Administrador (
    Email VARCHAR(32) NOT NULL,
    Username VARCHAR(32) NOT NULL,
    Senha VARCHAR(32) NOT NULL,
    Nome VARCHAR(32),
    Data_Nascimento DATE,
    CONSTRAINT PK_Administrador PRIMARY KEY (Email)
);

-- Tabela Cliente
CREATE TABLE Cliente (
    Email VARCHAR(32) NOT NULL,
    Username VARCHAR(32) NOT NULL,
    Senha VARCHAR(32) NOT NULL,
    Nome VARCHAR(32),
    Data_Nascimento DATE,
    Nivel_Conhecimento VARCHAR(13),
    Precisa_De_Atendimento BOOLEAN,
    CONSTRAINT PK_Cliente PRIMARY KEY (Email)
);

-- Tabela Voluntário
CREATE TABLE Voluntario (
    Email VARCHAR(32) NOT NULL,
    Username VARCHAR(32) NOT NULL,
    Senha VARCHAR(32) NOT NULL,
    Nome VARCHAR(32),
    Data_Nascimento DATE,
    CONSTRAINT PK_Voluntario PRIMARY KEY (Email)
);


-- Tabela Banimento
CREATE TABLE Banimento (
    Data_Hora DATE NOT NULL,
    Administrador_Email VARCHAR(32) NOT NULL,
    Voluntario_Email VARCHAR(32) NOT NULL,
    Motivo VARCHAR(128),
    Duracao TIMESTAMP,
    CONSTRAINT PK_Banimneto PRIMARY KEY (Data_Hora, Voluntario_Email),
    FOREIGN KEY (Administrador_Email) REFERENCES Administrador(Email)
        ON	DELETE	CASCADE,
    FOREIGN KEY (Voluntario_Email) REFERENCES Voluntario(Email)
        ON	DELETE	CASCADE
);

-- Tabela Capacidades
CREATE TABLE Capacidades (
    Voluntario_Email VARCHAR(32) NOT NULL,
    Capacidade VARCHAR(32) NOT NULL,
    CONSTRAINT PK_Capacidades PRIMARY KEY (Voluntario_Email, Capacidade),
    FOREIGN KEY (Voluntario_Email) REFERENCES Voluntario(Email)
        ON	DELETE	CASCADE
);

-- Tabela Modulo
CREATE TABLE Modulo (
    Tema VARCHAR(16) NOT NULL,
    Administrador_Email VARCHAR(32) NOT NULL,
    CONSTRAINT PK_Modulo PRIMARY KEY (Tema),
    FOREIGN KEY (Administrador_Email) REFERENCES Administrador(Email)
);

-- Tabela Cursa
CREATE TABLE Cursa (
    Cliente_Email VARCHAR(32) NOT NULL,
    Modulo_Tema VARCHAR(16) NOT NULL,
    Porcentagem_Progresso DECIMAL(4,2),
    CONSTRAINT PK_Cursa PRIMARY KEY (Cliente_Email, Modulo_Tema),
    FOREIGN KEY (Cliente_Email) REFERENCES Cliente(Email)
        ON	DELETE	CASCADE,
    FOREIGN KEY (Modulo_Tema) REFERENCES Modulo(Tema)
        ON	DELETE	CASCADE
);

-- Tabela Video Aula
CREATE TABLE VideoAula (
    Modulo_Tema VARCHAR(32) NOT NULL,
    Topico VARCHAR(32) NOT NULL,
    Descricao VARCHAR(512),
    Tempo INT,
    Url_video VARCHAR(128),
    CONSTRAINT PK_VideoAula PRIMARY KEY (Modulo_Tema, Topico),
    FOREIGN KEY (Modulo_Tema) REFERENCES Modulo(Tema)
        ON	DELETE	CASCADE
);

-- Tabela Avalia
CREATE TABLE Avalia (
    Cliente_Email VARCHAR(32) NOT NULL,
    Video_Tema VARCHAR(32) NOT NULL,
    Video_Topico VARCHAR(32) NOT NULL,
    Nota INT
        CHECK (Nota >= 0 AND Nota <= 10),
    PRIMARY KEY (Cliente_Email, Video_Tema, Video_Topico),
    FOREIGN KEY (Cliente_Email) REFERENCES Cliente(Email)
        ON	DELETE	CASCADE,
    FOREIGN KEY (Video_Tema , Video_Topico) REFERENCES VideoAula(Modulo_Tema, Video_Topico)
        ON	DELETE	CASCADE
);

-- Tabela Atendimento
CREATE TABLE Atendimento (
    Data_Hora DATE NOT NULL,
    Cliente_Email VARCHAR(32) NOT NULL,
    Voluntario_Email VARCHAR(32) NOT NULL,
    Nota INT,
    CONSTRAINT PK_Atendimento PRIMARY KEY (Data_Hora, Cliente_Email),
    CONSTRAINT CT_Nota CHECK(Nota BETWEEN 0 AND 10),
    FOREIGN KEY (Cliente_Email) REFERENCES Cliente(Email)
        ON	DELETE	CASCADE,
    FOREIGN KEY (Voluntario_Email) REFERENCES Voluntario(Email)
        ON	DELETE	CASCADE
);

-- Tabela Teste
CREATE TABLE Teste (
    Modulo_Tema VARCHAR(16) NOT NULL,
    Numero INT NOT NULL,
    Nivel_Dificuldade VARCHAR(13) NOT NULL,
    Tempo_para_completar DATE NOT NULL,
    CONSTRAINT PK_Teste PRIMARY KEY (Modulo_Tema, Numero),
    FOREIGN KEY (Modulo_Tema) REFERENCES Modulo(Tema)
        ON	DELETE	CASCADE
);

-- Tabela Resultado
CREATE TABLE Resultado (
    Id NUMBER,
    Cliente_Email VARCHAR(32) UNIQUE,
    Teste_Tema VARCHAR(16) UNIQUE,
    Teste_Numero INT UNIQUE,
    Data_Hora DATE UNIQUE,
    Mensagem_Feedback VARCHAR(256),
    Aprovacao BOOLEAN,
    CONSTRAINT PK_Resultado PRIMARY KEY (Id),
    FOREIGN KEY (Cliente_Email) REFERENCES Cliente(Email)
        ON	DELETE	CASCADE,
    FOREIGN KEY (Teste_Tema, Teste_Numero) REFERENCES Teste(Modulo_Tema,Numero)
        ON	DELETE	CASCADE
);

-- Tabela Questao
CREATE TABLE Questao (
    Id NUMBER,
    Topico VARCHAR(64) UNIQUE NOT NULL,
    Teste_Tema VARCHAR(16) UNIQUE NOT NULL,
    Teste_Numero INT UNIQUE NOT NULL,
    Pergunta VARCHAR(1024),
    Resposta_correta VARCHAR(1024),
    CONSTRAINT PK_Questao PRIMARY KEY (Id),
    FOREIGN KEY (Teste_Tema, Teste_Numero) REFERENCES Teste(Modulo_Tema,Numero)
        ON	DELETE	CASCADE
);

-- Tabela Medalha
CREATE TABLE Medalha (
    Nome VARCHAR(32) NOT NULL,
    Teste_Tema VARCHAR(16) NOT NULL,
    Teste_Numero INT NOT NULL,
    Descricao VARCHAR(128),
    CONSTRAINT PK_Medalha PRIMARY KEY (Teste_Tema, Teste_Numero, Nome),
    FOREIGN KEY (Teste_Tema, Teste_Numero)
        REFERENCES Teste(Modulo_Tema, Numero)
        ON	DELETE	CASCADE
);

-- Tabela Resposta Questao
CREATE TABLE RespostaQuestao (
    Resultado NOT NULL,
    Questao NOT NULL,
    Resposta_Cliente VARCHAR(1024),
    Acerto_da_Resposta BOOLEAN,
    CONSTRAINT PK_RespostaQuestao PRIMARY KEY (Resultado, Questao),
    FOREIGN KEY (Resultado) 
        REFERENCES Resultado(Id)
        ON	DELETE	CASCADE,
    FOREIGN KEY (Questao) REFERENCES Teste(Id)
        ON	DELETE	CASCADE
);

-- Tabela Alternativa
CREATE TABLE Alternativa (
    Questao_id NUMBER NOT NULL,
    Numero INT NOT NULL,
    Resposta BOOLEAN,
    Texto VARCHAR(512),
    CONSTRAINT PK_Alternativa PRIMARY KEY (Questao_id, Numero),
    FOREIGN KEY (Questao_id) REFERENCES Questao(Id)
        ON	DELETE	CASCADE
);