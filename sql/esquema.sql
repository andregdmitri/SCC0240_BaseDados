--Formato padrao para data
ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';

-- Tabela Administrador
CREATE TABLE Administrador (
    Email VARCHAR(32),
    Username VARCHAR(32),
    Senha VARCHAR(32),
    Nome VARCHAR(32),
    Data_Nascimento DATE,
    CONSTRAINT Null_adm CHECK (Email IS NOT NULL AND Username IS NOT NULL AND Senha IS NOT NULL),
    CONSTRAINT PK_Administrador PRIMARY KEY (Email)
);

-- Tabela Cliente
CREATE TABLE Cliente (
    Email VARCHAR(32),
    Username VARCHAR(32),
    Senha VARCHAR(32),
    Nome VARCHAR(32),
    Data_Nascimento DATE,
    Nivel_Conhecimento VARCHAR(13),
    Precisa_De_Atendimento NUMBER(1,0),
    CONSTRAINT Null_cliente CHECK (Email IS NOT NULL AND Username IS NOT NULL AND Senha IS NOT NULL),
    CONSTRAINT PK_Cliente PRIMARY KEY (Email)
);

-- Tabela Voluntário
CREATE TABLE Voluntario (
    Email VARCHAR(32),
    Username VARCHAR(32),
    Senha VARCHAR(32),
    Nome VARCHAR(32),
    Data_Nascimento DATE,
    CONSTRAINT Null_voluntario CHECK (Email IS NOT NULL AND Username IS NOT NULL AND Senha IS NOT NULL),
    CONSTRAINT PK_Voluntario PRIMARY KEY (Email)
);


-- Tabela Banimento
CREATE TABLE Banimento (
    Data_Hora DATE NOT NULL,
    Administrador_Email VARCHAR(32),
    Voluntario_Email VARCHAR(32),
    Motivo VARCHAR(128),
    Duracao TIMESTAMP,
    CONSTRAINT Null_banimento CHECK (Administrador_Email IS NOT NULL AND Voluntario_Email IS NOT NULL),
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
    CONSTRAINT Null_capacidades CHECK (Voluntario_Email IS NOT NULL AND Capacidade IS NOT NULL),
    CONSTRAINT PK_Capacidades PRIMARY KEY (Voluntario_Email, Capacidade),
    FOREIGN KEY (Voluntario_Email) REFERENCES Voluntario(Email)
        ON	DELETE	CASCADE
);

-- Tabela Modulo
CREATE TABLE Modulo (
    Tema VARCHAR(16),
    Administrador_Email VARCHAR(32),
    CONSTRAINT Null_modulo CHECK (Tema IS NOT NULL AND Administrador_Email IS NOT NULL),
    CONSTRAINT PK_Modulo PRIMARY KEY (Tema),
    FOREIGN KEY (Administrador_Email) REFERENCES Administrador(Email)
);

-- Tabela Cursa
CREATE TABLE Cursa (
    Cliente_Email VARCHAR(32),
    Modulo_Tema VARCHAR(32),
    Porcentagem_Progresso DECIMAL(4,2),
    CONSTRAINT Null_cursa CHECK (Cliente_Email IS NOT NULL AND Modulo_Tema IS NOT NULL),
    CONSTRAINT PK_Cursa PRIMARY KEY (Cliente_Email, Modulo_Tema),
    FOREIGN KEY (Cliente_Email) REFERENCES Cliente(Email)
        ON	DELETE	CASCADE,
    FOREIGN KEY (Modulo_Tema) REFERENCES Modulo(Tema)
        ON	DELETE	CASCADE
);

-- Tabela Video Aula
CREATE TABLE VideoAula (
    Modulo_Tema VARCHAR(32),
    Topico VARCHAR(32),
    Descricao VARCHAR(512),
    Tempo INT,
    Url_video VARCHAR(128),
    CONSTRAINT Null_videoaula 
        CHECK (Modulo_Tema IS NOT NULL AND Topico IS NOT NULL),
    CONSTRAINT PK_VideoAula PRIMARY KEY (Modulo_Tema, Topico),
    FOREIGN KEY (Modulo_Tema) REFERENCES Modulo(Tema)
        ON	DELETE	CASCADE
);

-- Tabela Avalia
CREATE TABLE Avalia (
    Cliente_Email VARCHAR(32),
    Video_Tema VARCHAR(32),
    Video_Topico VARCHAR(32),
    Nota INT
        CHECK (Nota >= 0 AND Nota <= 10),
    CONSTRAINT Null_avalia
        CHECK (Cliente_Email IS NOT NULL AND Video_Tema IS NOT NULL AND Video_Topico IS NOT NULL),
    PRIMARY KEY (Cliente_Email, Video_Tema, Video_Topico),
    FOREIGN KEY (Cliente_Email) REFERENCES Cliente(Email)
        ON	DELETE	CASCADE,
    FOREIGN KEY (Video_Tema , Video_Topico) REFERENCES VideoAula(Modulo_Tema, Topico)
        ON	DELETE	CASCADE
);

-- Tabela Atendimento
CREATE TABLE Atendimento (
    Data_Hora DATE NOT NULL,
    Cliente_Email VARCHAR(32) NOT NULL,
    Voluntario_Email VARCHAR(32) NOT NULL,
    Nota INT,
    CONSTRAINT Null_atendimento 
        CHECK (Cliente_Email IS NOT NULL AND Voluntario_Email IS NOT NULL),
    CONSTRAINT PK_Atendimento PRIMARY KEY (Data_Hora, Cliente_Email),
    CONSTRAINT CT_Nota 
        CHECK(Nota BETWEEN 0 AND 10),
    FOREIGN KEY (Cliente_Email) REFERENCES Cliente(Email)
        ON	DELETE	CASCADE,
    FOREIGN KEY (Voluntario_Email) REFERENCES Voluntario(Email)
        ON	DELETE	CASCADE
);

-- Tabela Teste
CREATE TABLE Teste (
    Modulo_Tema VARCHAR(32),
    Numero INT,
    Nivel_Dificuldade VARCHAR(13),
    Tempo_para_completar INTERVAL DAY TO SECOND,
    CONSTRAINT Null_teste 
        CHECK (Modulo_Tema IS NOT NULL AND Numero IS NOT NULL 
        AND Nivel_Dificuldade IS NOT NULL AND Tempo_para_completar IS NOT NULL),
    CONSTRAINT PK_Teste PRIMARY KEY (Modulo_Tema, Numero),
    FOREIGN KEY (Modulo_Tema) REFERENCES Modulo(Tema)
        ON	DELETE	CASCADE
);

-- Tabela Resultado
CREATE TABLE Resultado (
    Id_resultado NUMBER GENERATED by default on null as IDENTITY,
    Cliente_Email VARCHAR(32),
    Teste_Tema VARCHAR(16),
    Teste_Numero INT,
    Data_Hora DATE,
    Mensagem_Feedback VARCHAR(256),
    Aprovacao NUMBER(1,0),
    CONSTRAINT UNQ_Resultado UNIQUE(Cliente_Email, Teste_Tema, Teste_Numero, Data_Hora),
    CONSTRAINT PK_Resultado PRIMARY KEY (Id_resultado),
    FOREIGN KEY (Cliente_Email) REFERENCES Cliente(Email)
        ON	DELETE	CASCADE,
    FOREIGN KEY (Teste_Tema, Teste_Numero) REFERENCES Teste(Modulo_Tema,Numero)
        ON	DELETE	CASCADE
);

-- Tabela Questao
CREATE TABLE Questao (
    Id_questao NUMBER GENERATED by default on null as IDENTITY,
    Topico VARCHAR(64),
    Teste_Tema VARCHAR(16),
    Teste_Numero INT,
    Pergunta VARCHAR(1024),
    Resposta_correta VARCHAR(1024),
    CONSTRAINT Null_Questao
        CHECK (Topico IS NOT NULL AND Teste_Tema IS NOT NULL 
        AND Teste_Numero IS NOT NULL),
    CONSTRAINT UNQ_Questao UNIQUE(Topico, Teste_Tema, Teste_Numero),
    CONSTRAINT PK_Questao PRIMARY KEY (Id_questao),
    FOREIGN KEY (Teste_Tema, Teste_Numero) REFERENCES Teste(Modulo_Tema,Numero)
        ON	DELETE	CASCADE
);

-- Tabela Medalha
CREATE TABLE Medalha (
    Nome VARCHAR(32),
    Teste_Tema VARCHAR(16),
    Teste_Numero INT,
    Descricao VARCHAR(128),
    CONSTRAINT Null_Medalha
        CHECK (Nome IS NOT NULL AND Teste_Tema IS NOT NULL 
        AND Teste_Numero IS NOT NULL),
    CONSTRAINT PK_Medalha PRIMARY KEY (Teste_Tema, Teste_Numero, Nome),
    FOREIGN KEY (Teste_Tema, Teste_Numero)
        REFERENCES Teste(Modulo_Tema, Numero)
        ON	DELETE	CASCADE
);

-- Tabela Resposta Questao
CREATE TABLE RespostaQuestao (
    Resultado NUMBER,
    Questao NUMBER,
    Resposta_Cliente VARCHAR(1024),
    Acerto_da_Resposta NUMBER(1,0),
    CONSTRAINT Null_Resposta
        CHECK (Resultado IS NOT NULL AND Questao IS NOT NULL),
    CONSTRAINT PK_RespostaQuestao PRIMARY KEY (Resultado, Questao),
    FOREIGN KEY (Resultado) 
        REFERENCES Resultado(Id_resultado)
        ON	DELETE	CASCADE,
    FOREIGN KEY (Questao) REFERENCES Questao(Id_questao)
        ON	DELETE	CASCADE
);




-- Tabela Alternativa
CREATE TABLE Alternativa (
    Questao NUMBER,
    Numero INT,
    Resposta NUMBER(1,0),
    Texto VARCHAR(512),
    CONSTRAINT Null_Alternativa
        CHECK (Questao IS NOT NULL AND Numero IS NOT NULL),
    CONSTRAINT PK_Alternativa PRIMARY KEY (Questao, Numero),
    FOREIGN KEY (Questao) REFERENCES Questao(Id_questao)
        ON	DELETE	CASCADE
);