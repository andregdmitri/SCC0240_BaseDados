-- Verifica se um cliente especifico (Fernanda) 
-- acertou ou n�o a Pergunta da Quest�o 1
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

-- Verificando se h� algum email cadastrado em mais de uma
-- das tabelas Volunt�rio, Cliente e Administrador
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


-- Nota m�dia de um clinete escolhido (fernanda) que
-- que ganhou uma medalha escolhida (perfeccionista)
SELECT AVG(A.Nota) AS Media_Avaliacoes
FROM VideoAula VA
JOIN (
    SELECT A.Video_Tema, A.Video_Topico, A.Nota
    FROM Avalia A
    JOIN Resultado R ON R.Cliente_Email = A.Cliente_Email
    JOIN Medalha M ON M.Teste_Tema = R.Teste_Tema AND M.Teste_Numero = R.Teste_Numero
    WHERE R.Cliente_Email = 'fernanda@usp.br' -- Insira o email do usu�rio desejado
      AND M.Nome = 'Perfeccionista' -- Insira o nome da medalha desejada
) A ON A.Video_Tema = VA.Modulo_Tema AND A.Video_Topico = VA.Topico
GROUP BY VA.Topico;


-- Voluntarios que menos que 3 pessoas, 
-- tem nota abaixo de 5 
-- e tem menos de 3 capacidades
SELECT V.Email, V.Username
FROM Voluntario V
JOIN Atendimento A ON V.Email = A.Voluntario_Email
JOIN Capacidades C ON V.Email = C.Voluntario_Email
GROUP BY V.Email, V.Username
HAVING COUNT(DISTINCT A.Data_Hora) < 3
    AND AVG(A.Nota) < 5
    AND COUNT(DISTINCT C.Capacidade) < 3;

-- Cliente que cursou todos os modulos de um administrador especifico, 
-- nesse caso o adm Andr�.
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