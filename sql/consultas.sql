-- Total de avaliações por cliente
SELECT C.Email, C.Nome, (
    SELECT COUNT(*)
    FROM Avalia A
    WHERE A.Cliente_Email = C.Email
) AS Total_Avaliacoes
FROM Cliente C;

-- admnistradores que mais baniram
SELECT b.administrador_email, COUNT(*)
FROM banimento b JOIN administrador a
	ON b.administrador_email = a.email
GROUP BY b.administrador_email
ORDER BY COUNT(*) DESC;

-- média de avaliações por vídeo
SELECT a.video_tema, a.video_topico, AVG(nota)
FROM avalia a JOIN videoaula v
	ON a.video_tema = v.modulo_tema AND a.video_topico = v.topico
GROUP BY a.video_tema, a.video_topico;

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

-- voluntarios que nunca atenderam ninguem
SELECT V.Email
FROM Voluntario V
WHERE V.Email NOT IN (
    SELECT A.Voluntario_Email
    FROM Atendimento A
);

-- cliente que cursou todos os modulos DO ADM X
SELECT MAX(cliente_email) AS cliente_email
FROM cursa c
WHERE NOT EXISTS (
    (
        SELECT tema
        FROM modulo
    )
    MINUS
    (
        SELECT modulo_tema
        FROM cursa
        WHERE cliente_email = c.cliente_email
    )
)
GROUP BY cliente_email

--para cada usuarios qtd de testes que acertaram todas as alternaticvas