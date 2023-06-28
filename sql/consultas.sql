-- média de avaliações por vídeo
SELECT a.video_tema, a.video_topico, AVG(nota)
FROM avalia a JOIN videoaula v
	ON a.video_tema = v.modulo_tema AND a.video_topico = v.topico
GROUP BY a.video_tema, a.video_topico;

-- voluntarios sem nenhum atendimento
SELECT V.Email
FROM Voluntario V
WHERE V.Email NOT IN (
    SELECT A.Voluntario_Email
    FROM Atendimento A
);

-- admnistradores que mais baniram
SELECT b.administrador_email, COUNT(*)
FROM banimento b JOIN administrador a
	ON b.administrador_email = a.email
GROUP BY b.administrador_email
ORDER BY COUNT(*) DESC;

-- cliente que cursou todos os modulos
-- média de avaliações por vídeo
SELECT a.video_tema, a.video_topico, AVG(nota)
FROM avalia a JOIN videoaula v
	ON a.video_tema = v.modulo_tema AND a.video_topico = v.topico
GROUP BY a.video_tema, a.video_topico;

-- voluntarios sem nenhum atendimento
SELECT a.voluntario_email, COUNT(*)
FROM atendimento a JOIN voluntario v
	ON a.voluntario_email = v.email
GROUP BY a.voluntario_email
HAVING COUNT(*) = 0;

-- admnistradores que mais baniram
SELECT b.administrador_email, COUNT(*)
FROM banimento b JOIN administrador a
	ON b.administrador_email = a.email
GROUP BY b.administrador_email
ORDER BY COUNT(*) DESC;

-- cliente que cursou todos os modulos       
SELECT C.Email
FROM Cliente C
WHERE NOT EXISTS (
    SELECT M.Tema
    FROM Modulo M
    WHERE NOT EXISTS (
        SELECT CS.Modulo_tema
        FROM Cursa CS
        WHERE CS.Cliente_Email = C.Email
            AND CS.Modulo_Tema = M.Tema
    )
);