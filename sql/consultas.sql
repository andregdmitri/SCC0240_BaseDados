-- Verifica se um cliente especifico (Fernanda) 
-- acertou ou não a Pergunta da Questão 1
SELECT
    CASE WHEN Acerto_da_Resposta = 1 THEN 'sim' ELSE 'nao' END AS Resposta
FROM RespostaQuestao
WHERE Resultado IN (
    SELECT Id_resultado
    FROM Resultado
    WHERE Cliente_Email = 'fernanda@usp.br'
)
AND Questao IN (
    SELECT Id_questao
    FROM Questao
    WHERE Pergunta = 'Pergunta da Questao 1'
);

-- Verificando se há algum email cadastrado em mais de uma
-- das tabelas Voluntário, Cliente e Administrador
SELECT Email
FROM (
    SELECT Email
    FROM Cliente
    UNION ALL
    SELECT Email
    FROM Administrador
    UNION ALL
    SELECT Email
    FROM Voluntario
) Emails
GROUP BY Email
HAVING COUNT(*) > 1;


-- Nota média de um clinete escolhido (fernanda) que
-- que ganhou uma medalha escolhida (perfeccionista)
SELECT AVG(A.Nota) AS Media_Avaliacoes
FROM VideoAula VA
JOIN (
    SELECT A.Video_Tema, A.Video_Topico, A.Nota
    FROM Avalia A
    JOIN Resultado R ON R.Cliente_Email = A.Cliente_Email
    JOIN Medalha M ON M.Teste_Tema = R.Teste_Tema AND M.Teste_Numero = R.Teste_Numero
    WHERE R.Cliente_Email = 'fernanda@usp.br' -- Insira o email do usuário desejado
      AND M.Nome = 'Perfeccionista' -- Insira o nome da medalha desejada
) A ON A.Video_Tema = VA.Modulo_Tema AND A.Video_Topico = VA.Topico
GROUP BY VA.Topico;


-- Voluntarios que menos que 3 pessoas, 
-- tem nota abaixo de 5 
-- e tem menos de 3 capacidades
SELECT V.Email, V.Username
FROM Voluntario V
WHERE V.Email IN (
    SELECT A.Voluntario_Email
    FROM Atendimento A
    GROUP BY A.Voluntario_Email
    HAVING COUNT(A.Data_Hora) < 3 AND AVG(A.Nota) < 5
)
AND V.Email IN (
    SELECT C.Voluntario_Email
    FROM Capacidades C
    GROUP BY C.Voluntario_Email
    HAVING COUNT(C.Capacidade) < 3
);

-- Cliente que cursou todos os modulos de um administrador especifico, 
-- nesse caso o adm André.
SELECT MAX(cliente_email) AS cliente_email
FROM cursa c
WHERE NOT EXISTS (
    (
        SELECT tema
        FROM modulo
        WHERE administrador_email = 'andre@usp.br'
    )
    MINUS
    (
        SELECT modulo_tema
        FROM cursa
        WHERE cliente_email = c.cliente_email
    )
) GROUP BY cliente_email;