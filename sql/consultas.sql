-- média de avaliações por vídeo
SELECT a.video_tema, a.video_topico, AVG(nota)
FROM avalia a JOIN videoaula v
	ON a.video_tema = v.modulo_tema AND a.video_topico = v.topico
GROUP BY a.video_tema, a.video_topico

-- voluntarios sem nenhum atendimento
SELECT a.voluntario_email, COUNT(*)
FROM atendimento a JOIN voluntario v
	ON a.voluntario_email = v.email
GROUP BY a.voluntario_email
HAVING COUNT(*) = 0

-- admnistradores que mais baniram
SELECT b.administrador_email, COUNT(*)
FROM banimento b JOIN administrador a
	ON b.administrador_email = a.email
GROUP BY b.administrador_email
ORDER BY COUNT(*) DESC

-- cliente que cursou todos os modulos
SELECT cliente_email
FROM cursa c
WHERE NOT EXISTS ((SELECT tema
				   FROM modulo)
				 EXCEPT
				  (SELECT modulo_tema
				   FROM cursa
				   WHERE cliente_email = c.cliente_email))