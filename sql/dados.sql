-- Inserção de dados na tabela Administrador
INSERT INTO Administrador (Email, Username, Senha, Nome, Data_Nascimento)
VALUES ('admin1@example.com', 'admin1', 'senha123', 'Administrador 1', '1990-01-01');

INSERT INTO Administrador (Email, Username, Senha, Nome, Data_Nascimento)
VALUES ('admin2@example.com', 'admin2', 'senha456', 'Administrador 2', '1995-05-10');



-- Inserção de dados na tabela Cliente
INSERT INTO Cliente (Email, Username, Senha, Nome, Data_Nascimento, Nivel_Conhecimento, Precisa_De_Atendimento)
VALUES ('cliente1@example.com', 'cliente1', 'senha789', 'Cliente 1', '1992-03-15', 'Intermediário', 1);

INSERT INTO Cliente (Email, Username, Senha, Nome, Data_Nascimento, Nivel_Conhecimento, Precisa_De_Atendimento)
VALUES ('cliente2@example.com', 'cliente2', 'senhaabc', 'Cliente 2', '1988-11-20', 'Avançado', 0);



-- Inserção de dados na tabela Voluntario
INSERT INTO Voluntario (Email, Username, Senha, Nome, Data_Nascimento)
VALUES ('voluntario1@example.com', 'voluntario1', 'senhaxyz', 'Voluntário 1', '1993-06-25');

INSERT INTO Voluntario (Email, Username, Senha, Nome, Data_Nascimento)
VALUES ('voluntario2@example.com', 'voluntario2', 'senha123abc', 'Voluntário 2', '1998-09-05');



-- Inserção de dados na tabela Banimento
INSERT INTO Banimento (Data_Hora, Administrador_Email, Voluntario_Email, Motivo, Duracao)
VALUES (SYSDATE, 'admin1@example.com', 'voluntario1@example.com', 'Comportamento inadequado', TIMESTAMP '2023-06-30 23:59:59');

INSERT INTO Banimento (Data_Hora, Administrador_Email, Voluntario_Email, Motivo, Duracao)
VALUES (SYSDATE, 'admin2@example.com', 'voluntario2@example.com', 'Violação das regras do programa', TIMESTAMP '2023-07-31 23:59:59');



-- Inserção de dados na tabela Capacidades
INSERT INTO Capacidades (Voluntario_Email, Capacidade)
VALUES ('voluntario1@example.com', 'Capacidade 1');

INSERT INTO Capacidades (Voluntario_Email, Capacidade)
VALUES ('voluntario2@example.com', 'Capacidade 2');



-- Inserção de dados na tabela Modulo
INSERT INTO Modulo (Tema, Administrador_Email)
VALUES ('Tema 1', 'admin1@example.com');

INSERT INTO Modulo (Tema, Administrador_Email)
VALUES ('Tema 2', 'admin2@example.com');



-- Inserção de dados na tabela Cursa
INSERT INTO Cursa (Cliente_Email, Modulo_Tema, Porcentagem_Progresso)
VALUES ('cliente1@example.com', 'Tema 1', 75.5);

INSERT INTO Cursa (Cliente_Email, Modulo_Tema, Porcentagem_Progresso)
VALUES ('cliente2@example.com', 'Tema 2', 50.2);



-- Inserção de dados na tabela VideoAula
INSERT INTO VideoAula (Modulo_Tema, Topico, Descricao, Tempo, Url_video)
VALUES ('Tema 1', 'Topico 1', 'Descrição do Tópico 1', 120, 'https://example.com/video1');

INSERT INTO VideoAula (Modulo_Tema, Topico, Descricao, Tempo, Url_video)
VALUES ('Tema 2', 'Topico 2', 'Descrição do Tópico 2', 90, 'https://example.com/video2');



-- Inserção de dados na tabela Avalia
INSERT INTO Avalia (Cliente_Email, Video_Tema, Video_Topico, Nota)
VALUES ('cliente1@example.com', 'Tema 1', 'Topico 1', 9);

INSERT INTO Avalia (Cliente_Email, Video_Tema, Video_Topico, Nota)
VALUES ('cliente2@example.com', 'Tema 2', 'Topico 2', 8);



-- Inserção de dados na tabela Atendimento
INSERT INTO Atendimento (Data_Hora, Cliente_Email, Voluntario_Email, Nota)
VALUES (SYSDATE, 'cliente1@example.com', 'voluntario1@example.com', 10);

INSERT INTO Atendimento (Data_Hora, Cliente_Email, Voluntario_Email, Nota)
VALUES (SYSDATE, 'cliente2@example.com', 'voluntario2@example.com', 7);



-- Inserção de dados na tabela Teste
INSERT INTO Teste (Modulo_Tema, Numero, Nivel_Dificuldade, Tempo_para_completar)
VALUES ('Tema 1', 1, 'Fácil', DATE '2023-06-15');

INSERT INTO Teste (Modulo_Tema, Numero, Nivel_Dificuldade, Tempo_para_completar)
VALUES ('Tema 2', 1, 'Médio', DATE '2023-06-20');



-- Inserção de dados na tabela Resultado
INSERT INTO Resultado (Id, Cliente_Email, Teste_Tema, Teste_Numero, Data_Hora, Mensagem_Feedback, Aprovacao)
VALUES (1, 'cliente1@example.com', 'Tema 1', 1, SYSDATE, 'Feedback do Teste 1', 1);

INSERT INTO Resultado (Id, Cliente_Email, Teste_Tema, Teste_Numero, Data_Hora, Mensagem_Feedback, Aprovacao)
VALUES (2, 'cliente2@example.com', 'Tema 2', 1, SYSDATE, 'Feedback do Teste 2', 0);



-- Inserção de dados na tabela Questao
INSERT INTO Questao (Id, Topico, Teste_Tema, Teste_Numero, Pergunta, Resposta_correta)
VALUES (1, 'Topico 1', 'Tema 1', 1, 'Pergunta da Questão 1', 'Resposta correta da Questão 1');

INSERT INTO Questao (Id, Topico, Teste_Tema, Teste_Numero, Pergunta, Resposta_correta)
VALUES (2, 'Topico 2', 'Tema 2', 1, 'Pergunta da Questão 2', 'Resposta correta da Questão 2');



-- Inserção de dados na tabela Medalha
INSERT INTO Medalha (Nome, Teste_Tema, Teste_Numero, Descricao)
VALUES ('Medalha 1', 'Tema 1', 1, 'Descrição da Medalha 1');

INSERT INTO Medalha (Nome, Teste_Tema, Teste_Numero, Descricao)
VALUES ('Medalha 2', 'Tema 2', 1, 'Descrição da Medalha 2');



-- Inserção de dados na tabela RespostaQuestao
INSERT INTO RespostaQuestao (Resultado, Questao, Resposta_Cliente, Acerto_da_Resposta)
VALUES (1, 1, 'Resposta do Cliente 1', 1);

INSERT INTO RespostaQuestao (Resultado, Questao, Resposta_Cliente, Acerto_da_Resposta)
VALUES (2, 2, 'Resposta do Cliente 2', 0);


-- Inserção de dados na tabela Alternativa
INSERT INTO Alternativa (Questao_id, Numero, Resposta, Texto)
VALUES (1, 1, 1, 'Alternativa 1 da Questão 1');

INSERT INTO Alternativa (Questao_id, Numero, Resposta, Texto)
VALUES (1, 2, 0, 'Alternativa 2 da Questão 1');



-- Inserção de dados na tabela Banimento
INSERT INTO Banimento (Data_Hora, Administrador_Email, Voluntario_Email, Motivo, Duracao)
VALUES (SYSDATE, 'admin1@example.com', 'voluntario1@example.com', 'Comportamento inadequado', TIMESTAMP '2023-06-30 23:59:59');

INSERT INTO Banimento (Data_Hora, Administrador_Email, Voluntario_Email, Motivo, Duracao)
VALUES (SYSDATE, 'admin2@example.com', 'voluntario2@example.com', 'Violação das regras do programa', TIMESTAMP '2023-07-31 23:59:59');



-- Inserção de dados na tabela Capacidades
INSERT INTO Capacidades (Voluntario_Email, Capacidade)
VALUES ('voluntario1@example.com', 'Capacidade 1');

INSERT INTO Capacidades (Voluntario_Email, Capacidade)
VALUES ('voluntario2@example.com', 'Capacidade 2');



-- Inserção de dados na tabela Modulo
INSERT INTO Modulo (Tema, Administrador_Email)
VALUES ('Tema 1', 'admin1@example.com');

INSERT INTO Modulo (Tema, Administrador_Email)
VALUES ('Tema 2', 'admin2@example.com');



-- Inserção de dados na tabela Cursa
INSERT INTO Cursa (Cliente_Email, Modulo_Tema, Porcentagem_Progresso)
VALUES ('cliente1@example.com', 'Tema 1', 75.5);

INSERT INTO Cursa (Cliente_Email, Modulo_Tema, Porcentagem_Progresso)
VALUES ('cliente2@example.com', 'Tema 2', 50.2);



-- Inserção de dados na tabela VideoAula
INSERT INTO VideoAula (Modulo_Tema, Topico, Descricao, Tempo, Url_video)
VALUES ('Tema 1', 'Topico 1', 'Descrição do Tópico 1', 120, 'https://example.com/video1');

INSERT INTO VideoAula (Modulo_Tema, Topico, Descricao, Tempo, Url_video)
VALUES ('Tema 2', 'Topico 2', 'Descrição do Tópico 2', 90, 'https://example.com/video2');



-- Inserção de dados na tabela Avalia
INSERT INTO Avalia (Cliente_Email, Video_Tema, Video_Topico, Nota)
VALUES ('cliente1@example.com', 'Tema 1', 'Topico 1', 9);

INSERT INTO Avalia (Cliente_Email, Video_Tema, Video_Topico, Nota)
VALUES ('cliente2@example.com', 'Tema 2', 'Topico 2', 8);



-- Inserção de dados na tabela Atendimento
INSERT INTO Atendimento (Data_Hora, Cliente_Email, Voluntario_Email, Nota)
VALUES (SYSDATE, 'cliente1@example.com', 'voluntario1@example.com', 10);

INSERT INTO Atendimento (Data_Hora, Cliente_Email, Voluntario_Email, Nota)
VALUES (SYSDATE, 'cliente2@example.com', 'voluntario2@example.com', 7);



-- Inserção de dados na tabela Teste
INSERT INTO Teste (Modulo_Tema, Numero, Nivel_Dificuldade, Tempo_para_completar)
VALUES ('Tema 1', 1, 'Fácil', DATE '2023-06-15');

INSERT INTO Teste (Modulo_Tema, Numero, Nivel_Dificuldade, Tempo_para_completar)
VALUES ('Tema 2', 1, 'Médio', DATE '2023-06-20');



-- Inserção de dados na tabela Resultado
INSERT INTO Resultado (Id, Cliente_Email, Teste_Tema, Teste_Numero, Data_Hora, Mensagem_Feedback, Aprovacao)
VALUES (1, 'cliente1@example.com', 'Tema 1', 1, SYSDATE, 'Feedback do Teste 1', 1);

INSERT INTO Resultado (Id, Cliente_Email, Teste_Tema, Teste_Numero, Data_Hora, Mensagem_Feedback, Aprovacao)
VALUES (2, 'cliente2@example.com', 'Tema 2', 1, SYSDATE, 'Feedback do Teste 2', 0);



-- Inserção de dados na tabela Questao
INSERT INTO Questao (Id, Topico, Teste_Tema, Teste_Numero, Pergunta, Resposta_correta)
VALUES (1, 'Topico 1', 'Tema 1', 1, 'Pergunta da Questão 1', 'Resposta correta da Questão 1');

INSERT INTO Questao (Id, Topico, Teste_Tema, Teste_Numero, Pergunta, Resposta_correta)
VALUES (2, 'Topico 2', 'Tema 2', 1, 'Pergunta da Questão 2', 'Resposta correta da Questão 2');



-- Inserção de dados na tabela Medalha
INSERT INTO Medalha (Nome, Teste_Tema, Teste_Numero, Descricao)
VALUES ('Medalha 1', 'Tema 1', 1, 'Descrição da Medalha 1');

INSERT INTO Medalha (Nome, Teste_Tema, Teste_Numero, Descricao)
VALUES ('Medalha 2', 'Tema 2', 1, 'Descrição da Medalha 2');



-- Inserção de dados na tabela RespostaQuestao
INSERT INTO RespostaQuestao (Resultado, Questao, Resposta_Cliente, Acerto_da_Resposta)
VALUES (1, 1, 'Resposta do Cliente 1', 0);

INSERT INTO RespostaQuestao (Resultado, Questao, Resposta_Cliente, Acerto_da_Resposta)
VALUES (2, 2, 'Resposta do Cliente 2', 0);



-- Inserção de dados na tabela Alternativa
INSERT INTO Alternativa (Questao_id, Numero, Resposta, Texto)
VALUES (1, 1, 1, 'Alternativa 1 da Questão 1');

INSERT INTO Alternativa (Questao_id, Numero, Resposta, Texto)
VALUES (1, 2, 0, 'Alternativa 2 da Questão 1');
