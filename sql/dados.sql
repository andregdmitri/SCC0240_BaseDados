-- Inser��o de dados na tabela Administrador
INSERT INTO Administrador (Email, Username, Senha, Nome, Data_Nascimento)
VALUES ('andre@usp.com', 'andre', 'senha123', 'Andre Mitri', '1999-01-01');

INSERT INTO Administrador (Email, Username, Senha, Nome, Data_Nascimento)
VALUES ('fabio@usp.br', 'fabio', 'senha456', 'Fabio', '2000-05-10');



-- Inser��o de dados na tabela Cliente
INSERT INTO Cliente (Email, Username, Senha, Nome, Data_Nascimento, Nivel_Conhecimento, Precisa_De_Atendimento)
VALUES ('fernanda@usp.br', 'fernanda', 'senha789', 'Fernanda S', '2000-03-15', 'Intermediario', 1);

INSERT INTO Cliente (Email, Username, Senha, Nome, Data_Nascimento, Nivel_Conhecimento, Precisa_De_Atendimento)
VALUES ('vitor@usp.br', 'vitor', 'senhaabc', 'Vitor O', '2001-11-20', 'Avan�ado', 0);


-- Inser��o de dados na tabela Voluntario
INSERT INTO Voluntario (Email, Username, Senha, Nome, Data_Nascimento)
VALUES ('leo@usp.br', 'leonardo', 'senhaxyz', 'Leonardo T', '2001-06-25');

INSERT INTO Voluntario (Email, Username, Senha, Nome, Data_Nascimento)
VALUES ('bia@usp.br', 'bia', 'senha123abc', 'Bianca', '2000-09-05');

INSERT INTO Voluntario (Email, Username, Senha, Nome, Data_Nascimento)
VALUES ('luis@usp.br', 'luis', 'sen1aabc', 'Luis V', '2001-11-20');



-- Inser��o de dados na tabela Banimento
INSERT INTO Banimento (Data_Hora, Administrador_Email, Voluntario_Email, Motivo, Duracao)
VALUES (SYSDATE, 'andre@usp.com', 'leo@usp.br', 'Comportamento inadequado', TIMESTAMP '2023-04-30 23:59:59');

INSERT INTO Banimento (Data_Hora, Administrador_Email, Voluntario_Email, Motivo, Duracao)
VALUES (SYSDATE, 'fabio@usp.br', 'bia@usp.br', 'Viola��o das regras da comunidad', TIMESTAMP '2022-02-02 23:59:59');



-- Inser��o de dados na tabela Capacidades
INSERT INTO Capacidades (Voluntario_Email, Capacidade)
VALUES ('leo@usp.br', 'Redes Sociais');

INSERT INTO Capacidades (Voluntario_Email, Capacidade)
VALUES ('bia@usp.br', 'Pesquisas Google');



-- Inser��o de dados na tabela Modulo
INSERT INTO Modulo (Tema, Administrador_Email)
VALUES ('Buscas no Google', 'andre@usp.com');

INSERT INTO Modulo (Tema, Administrador_Email)
VALUES ('Redes Sociais', 'fabio@usp.br');



-- Inser��o de dados na tabela Cursa
INSERT INTO Cursa (Cliente_Email, Modulo_Tema, Porcentagem_Progresso)
VALUES ('fernanda@usp.br', 'Buscas no Google', 75.5);

INSERT INTO Cursa (Cliente_Email, Modulo_Tema, Porcentagem_Progresso)
VALUES ('vitor@usp.br', 'Redes Sociais', 50.2);

INSERT INTO Cursa (Cliente_Email, Modulo_Tema, Porcentagem_Progresso)
VALUES ('vitor@usp.br', 'Buscas no Google', 30.2);



-- Inser��o de dados na tabela VideoAula
INSERT INTO VideoAula (Modulo_Tema, Topico, Descricao, Tempo, Url_video)
VALUES ('Buscas no Google', 'Introducao as Buscas', 'Como fazer pesquisas no Google e principais dicas', 120, 'https://www.youtube.com/watch?v=dQw4w9WgXcQ');

INSERT INTO VideoAula (Modulo_Tema, Topico, Descricao, Tempo, Url_video)
VALUES ('Redes Sociais', 'Redes Sociais mais utilizadas', 'Introducao sobre o Instagram, Facebook e o Twitter', 90, 'https://www.youtube.com/watch?v=oHg5SJYRHA0');



-- Inser��o de dados na tabela Avalia
INSERT INTO Avalia (Cliente_Email, Video_Tema, Video_Topico, Nota)
VALUES ('fernanda@usp.br', 'Buscas no Google', 'Introducao as Buscas', 9);

INSERT INTO Avalia (Cliente_Email, Video_Tema, Video_Topico, Nota)
VALUES ('vitor@usp.br', 'Redes Sociais', 'Redes Sociais mais utilizadas', 8);

INSERT INTO Avalia (Cliente_Email, Video_Tema, Video_Topico, Nota)
VALUES ('vitor@usp.br', 'Buscas no Google', 'Introducao as Buscas', 10);

-- Inser��o de dados na tabela Atendimento
INSERT INTO Atendimento (Data_Hora, Cliente_Email, Voluntario_Email, Nota)
VALUES (SYSDATE, 'fernanda@usp.br', 'leo@usp.br', 10);

INSERT INTO Atendimento (Data_Hora, Cliente_Email, Voluntario_Email, Nota)
VALUES (SYSDATE, 'fernanda@usp.br', 'bia@usp.br', 7);



-- Inser��o de dados na tabela Teste
INSERT INTO Teste (Modulo_Tema, Numero, Nivel_Dificuldade, Tempo_para_completar)
VALUES ('Buscas no Google', 1, 'Facil', TO_DSINTERVAL('4 23:59:59'));

INSERT INTO Teste (Modulo_Tema, Numero, Nivel_Dificuldade, Tempo_para_completar)
VALUES ('Redes Sociais', 1, 'Medio', TO_DSINTERVAL('2 23:59:59'));



-- Inser��o de dados na tabela Resultado
INSERT INTO Resultado (Id_resultado, Cliente_Email, Teste_Tema, Teste_Numero, Data_Hora, Mensagem_Feedback, Aprovacao)
VALUES (1, 'fernanda@usp.br', 'Buscas no Google', 1, SYSDATE, 'Feedback do Teste 1', 1);

INSERT INTO Resultado (Id_resultado, Cliente_Email, Teste_Tema, Teste_Numero, Data_Hora, Mensagem_Feedback, Aprovacao)
VALUES (2, 'vitor@usp.br', 'Redes Sociais', 1, SYSDATE, 'Feedback do Teste 2', 0);



-- Inser��o de dados na tabela Questao
INSERT INTO Questao (Id_questao, Topico, Teste_Tema, Teste_Numero, Pergunta, Resposta_correta)
VALUES (1, 'Introducao as Buscas', 'Buscas no Google', 1, 'Pergunta da Quest�o 1', 'Resposta correta da Quest�o 1');

INSERT INTO Questao (Id_questao, Topico, Teste_Tema, Teste_Numero, Pergunta, Resposta_correta)
VALUES (2, 'Redes Sociais mais utilizadas', 'Redes Sociais', 1, 'Pergunta da Quest�o 2', 'Resposta correta da Quest�o 2');



-- Inser��o de dados na tabela Medalha
INSERT INTO Medalha (Nome, Teste_Tema, Teste_Numero, Descricao)
VALUES ('Perfeccionista', 'Buscas no Google', 1, '100% de acerto!');

INSERT INTO Medalha (Nome, Teste_Tema, Teste_Numero, Descricao)
VALUES ('Veloz', 'Redes Sociais', 1, 'Terminou em tempo recorde!');



-- Inser��o de dados na tabela RespostaQuestao
INSERT INTO RespostaQuestao (Resultado, Questao, Resposta_Cliente, Acerto_da_Resposta)
VALUES (1, 1, 'Resposta do Cliente 1', 1);

INSERT INTO RespostaQuestao (Resultado, Questao, Resposta_Cliente, Acerto_da_Resposta)
VALUES (2, 2, 'Resposta do Cliente 2', 0);



-- Inser��o de dados na tabela Alternativa
INSERT INTO Alternativa (Questao, Numero, Resposta, Texto)
VALUES (1, 1, 1, 'Alternativa 1 da Quest�o 1');

INSERT INTO Alternativa (Questao, Numero, Resposta, Texto)
VALUES (1, 2, 0, 'Alternativa 2 da Quest�o 1');

commit;