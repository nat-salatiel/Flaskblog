-- Seleciona os campos abaixo da tabela `article`
-- RN --> Regra de negócio
SELECT art_id, art_title, art_thumbnail 
FROM article
WHERE art_author = %s -- Deste autor
	AND art_id != %s  -- Não obtém o artigo atual
    AND art_status = 'on' -- Status sempre 'on' (RN)
    AND art_date <= NOW() -- Data no passado ou presente (RN)
ORDER BY RAND() -- Ordena aleatoriamente
LIMIT %s; -- Obtém o limite