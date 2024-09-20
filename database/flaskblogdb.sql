-- Apaga o Banco de Dados se ele existir.
DROP DATABASE IF EXISTS flaskblogdb;

-- Recria o Banco de Dados
CREATE DATABASE flaskblogdb
-- Usando a tabela de caracteres universal extendida
	CHARACTER SET utf8mb4
-- Buscas também em utf8 e case insensitive
	COLLATE utf8mb4_general_ci;
    
-- Seleciona o Banco de Dados para os próximos comandos 
USE flaskblogdb;

-- Cria a tabela 'staff' conforme o modelo lógico
CREATE TABLE staff(
	-- Define o id como chave primária
	emp_id INT PRIMARY KEY AUTO_INCREMENT, 
    -- Define a data com valor do sistema
    emp_date TIMESTAMP DEFAULT current_timestamp,
    -- Define o nome do usuário com 127 caracteres
    emp_name VARCHAR(127) NOT NULL,
    -- Define o email do usuário com 255 caracteres (RFC)
    emp_email VARCHAR(255) NOT NULL,
    -- Define a senha do usuário com 63 caracteres
    emp_password VARCHAR(63) NOT NULL,
    -- Define a imagem do usuário com 255 caracteres
    emp_image VARCHAR(255),
    -- Data em formato ISO / System Date
    emp_birth DATE NOT NULL, 
    -- Define a descrição do usuário com 255 caracteres
    emp_description VARCHAR(255),
    -- Define lista com a opção 'moderator' como padrão
    emp_type ENUM('admin', 'author', 'moderator') 
    DEFAULT 'moderator',
    -- Define lista com a opção 'on' como padrão
    emp_status ENUM('on', 'off', 'del') DEFAULT 'on'
);

-- Cria a tabela 'article' conforme o modelo lógico
CREATE TABLE article(
	art_id INT PRIMARY KEY AUTO_INCREMENT, 
    art_date TIMESTAMP DEFAULT current_timestamp,
    art_author INT NOT NULL, 
    art_title VARCHAR(127) NOT NULL,
    art_resume VARCHAR(255) NOT NULL,
    art_thumbnail VARCHAR(255) NOT NULL,
    art_content TEXT NOT NULL,
	art_views INT NOT NULL DEFAULT 0,
	art_status ENUM('on', 'off', 'del')  DEFAULT 'on',
    FOREIGN KEY (art_author) REFERENCES staff (emp_id)
);

-- Cria a tabela 'comment' conforme o modelo lógico
CREATE TABLE comment(
	com_id INT PRIMARY KEY AUTO_INCREMENT, 
    com_date TIMESTAMP DEFAULT current_timestamp,
    com_article INT NOT NULL,
    com_author_name VARCHAR(127) NOT NULL, 
    com_author_email VARCHAR(255) NOT NULL,
    com_comment TEXT,
	com_status ENUM('on', 'off', 'del')  DEFAULT 'on',
    FOREIGN KEY (com_article) REFERENCES article (art_id)
);

-- Cria a tabela 'contact' conforme o modelo lógico
CREATE TABLE contact(
id INT PRIMARY KEY AUTO_INCREMENT,
date  TIMESTAMP DEFAULT current_timestamp,
name VARCHAR(127) NOT NULL,
email VARCHAR(255) NOT NULL,
subject VARCHAR(255) NOT NULL,
messsage TEXT,
status ENUM('on', 'off', 'del') DEFAULT 'on'
);

-- -------------------------------- --
-- Populando tabelas com dados fake --
-- -------------------------------- --
-- Insere dados na tabela 'staff'
INSERT INTO staff (
	emp_name,
    emp_email,
    emp_password,
    emp_image,
    emp_birth, 
    emp_description
) VALUES(
	'Lucas Oliveira',
    'lucas@oliveira.com',
    SHA1('Senha456'),
    'https://randomuser.me/api/portraits/lego/2.jpg',
    '1995-07-15',
    'Designer gráfico e criador de conteúdo.'
), (
	'Aline Costa',
    'aline@costa.com',
    SHA1('Senha789'),
    'https://randomuser.me/api/portraits/lego/3.jpg',
    '1992-11-30',
    'Gerente de projetos e especialista em Agile.'
), (
	'Ricardo Almeida',
    'ricardo@almeida.com',
    SHA1('Senha321'),
    'https://randomuser.me/api/portraits/lego/4.jpg',
    '1988-01-20',
    'Analista de sistemas com foco em segurança da informação.'
), (
	'Julia Santos',
    'julia@santos.com',
    SHA1('Senha654'),
    'https://randomuser.me/api/portraits/lego/5.jpg',
    '1996-05-12',
    'Desenvolvedora full-stack e entusiasta de tecnologia.'
), (
	'Felipe Martins',
    'felipe@martins.com',
    SHA1('Senha987'),
    'https://randomuser.me/api/portraits/lego/6.jpg',
    '1990-09-25',
    'Especialista em marketing digital e SEO.'
);

-- Atualiza o type do staff
UPDATE `flaskblogdb`.`staff` SET `emp_type` = 'admin' WHERE (`emp_id` = '1');
UPDATE `flaskblogdb`.`staff` SET `emp_type` = 'author' WHERE (`emp_id` = '2');
UPDATE `flaskblogdb`.`staff` SET `emp_type` = 'author' WHERE (`emp_id` = '4');


-- Insere dados na tabela 'article' --
INSERT INTO article(
	art_author, 
    art_title,
    art_resume,
    art_thumbnail,
    art_content
) VALUES (
-- 'emp_id' de um staff existente --
	'2',
    'Primeiro artigo',
    -- Deixe os mesmos valores para todos os outros artigos --
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maiores quidem voluptatibus provident velit dolorum beatae, rem qui amet hic officia non dolores explicabo voluptas cupiditate sapiente quibusdam esse debitis laborum!</p>
<p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Quisquam veritatis, quaerat quibusdam voluptate, consequuntur est impedit deleniti rem doloribus in fuga, incidunt quidem veniam facere perferendis aspernatur nulla? Consectetur, voluptatem.</p>
<img src="https://picsum.photos/200" alt="imagem aleatória">
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Temporibus, eum. Velit sapiente earum officiis voluptatum. Quibusdam neque iste harum saepe voluptas accusantium incidunt reprehenderit, necessitatibus sed debitis porro, molestiae consequuntur?</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://www.linkedin.com/in/natalia-salatiel-desenvolvedora-web">Meu Linkedin</a></li>
    <li><a href="https://github.com/nat-salatiel">Meu Github</a></li>
</ul>

<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Repudiandae autem minima maxime aut sit quis repellat omnis, quo aliquid minus consequatur saepe, quas quam porro officiis perferendis facere enim perspiciatis!</p>'
), (
-- 'emp_id' de um staff existente --
	'1',
    'Segundo artigo',
    -- Deixe os mesmos valores para todos os outros artigos --
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maiores quidem voluptatibus provident velit dolorum beatae, rem qui amet hic officia non dolores explicabo voluptas cupiditate sapiente quibusdam esse debitis laborum!</p>
<p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Quisquam veritatis, quaerat quibusdam voluptate, consequuntur est impedit deleniti rem doloribus in fuga, incidunt quidem veniam facere perferendis aspernatur nulla? Consectetur, voluptatem.</p>
<img src="https://picsum.photos/200" alt="imagem aleatória">
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Temporibus, eum. Velit sapiente earum officiis voluptatum. Quibusdam neque iste harum saepe voluptas accusantium incidunt reprehenderit, necessitatibus sed debitis porro, molestiae consequuntur?</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://www.linkedin.com/in/natalia-salatiel-desenvolvedora-web">Meu Linkedin</a></li>
    <li><a href="https://github.com/nat-salatiel">Meu Github</a></li>
</ul>

<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Repudiandae autem minima maxime aut sit quis repellat omnis, quo aliquid minus consequatur saepe, quas quam porro officiis perferendis facere enim perspiciatis!</p>'
), (
-- 'emp_id' de um staff existente --
	'3',
    'Terceiro artigo',
    -- Deixe os mesmos valores para todos os outros artigos --
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maiores quidem voluptatibus provident velit dolorum beatae, rem qui amet hic officia non dolores explicabo voluptas cupiditate sapiente quibusdam esse debitis laborum!</p>
<p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Quisquam veritatis, quaerat quibusdam voluptate, consequuntur est impedit deleniti rem doloribus in fuga, incidunt quidem veniam facere perferendis aspernatur nulla? Consectetur, voluptatem.</p>
<img src="https://picsum.photos/200" alt="imagem aleatória">
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Temporibus, eum. Velit sapiente earum officiis voluptatum. Quibusdam neque iste harum saepe voluptas accusantium incidunt reprehenderit, necessitatibus sed debitis porro, molestiae consequuntur?</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://www.linkedin.com/in/natalia-salatiel-desenvolvedora-web">Meu Linkedin</a></li>
    <li><a href="https://github.com/nat-salatiel">Meu Github</a></li>
</ul>

<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Repudiandae autem minima maxime aut sit quis repellat omnis, quo aliquid minus consequatur saepe, quas quam porro officiis perferendis facere enim perspiciatis!</p>'
), (
-- 'emp_id' de um staff existente --
	'4',
    'Quarto artigo',
    -- Deixe os mesmos valores para todos os outros artigos --
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maiores quidem voluptatibus provident velit dolorum beatae, rem qui amet hic officia non dolores explicabo voluptas cupiditate sapiente quibusdam esse debitis laborum!</p>
<p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Quisquam veritatis, quaerat quibusdam voluptate, consequuntur est impedit deleniti rem doloribus in fuga, incidunt quidem veniam facere perferendis aspernatur nulla? Consectetur, voluptatem.</p>
<img src="https://picsum.photos/200" alt="imagem aleatória">
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Temporibus, eum. Velit sapiente earum officiis voluptatum. Quibusdam neque iste harum saepe voluptas accusantium incidunt reprehenderit, necessitatibus sed debitis porro, molestiae consequuntur?</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://www.linkedin.com/in/natalia-salatiel-desenvolvedora-web">Meu Linkedin</a></li>
    <li><a href="https://github.com/nat-salatiel">Meu Github</a></li>
</ul>

<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Repudiandae autem minima maxime aut sit quis repellat omnis, quo aliquid minus consequatur saepe, quas quam porro officiis perferendis facere enim perspiciatis!</p>'
), (
-- 'emp_id' de um staff existente --
	'5',
    'Quinto artigo',
    -- Deixe os mesmos valores para todos os outros artigos --
    'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
    'https://picsum.photos/300',
    '<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Maiores quidem voluptatibus provident velit dolorum beatae, rem qui amet hic officia non dolores explicabo voluptas cupiditate sapiente quibusdam esse debitis laborum!</p>
<p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Quisquam veritatis, quaerat quibusdam voluptate, consequuntur est impedit deleniti rem doloribus in fuga, incidunt quidem veniam facere perferendis aspernatur nulla? Consectetur, voluptatem.</p>
<img src="https://picsum.photos/200" alt="imagem aleatória">
<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Temporibus, eum. Velit sapiente earum officiis voluptatum. Quibusdam neque iste harum saepe voluptas accusantium incidunt reprehenderit, necessitatibus sed debitis porro, molestiae consequuntur?</p>
<h4>Links:</h4>
<ul>
    <li><a href="https://www.linkedin.com/in/natalia-salatiel-desenvolvedora-web">Meu Linkedin</a></li>
    <li><a href="https://github.com/nat-salatiel">Meu Github</a></li>
</ul>

<p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Repudiandae autem minima maxime aut sit quis repellat omnis, quo aliquid minus consequatur saepe, quas quam porro officiis perferendis facere enim perspiciatis!</p>'
) ;


-- Insere dados na tabela 'article' --
INSERT INTO comment(
	-- Inserir um 'art_id' existente --
    com_article,
    com_author_name, 
    com_author_email,
    com_comment
) VALUES(
	'5',
	'João Pedro',
	'joao@pedro.com',
	'Ótimo artigo! Muito informativo.'
), (
	'4',
	'Larissa Gomes',
	'larissa@gomes.com',
	'Adorei as dicas, vou aplicar com certeza!'
), (
	'3',
	'Ricardo Lima',
	'ricardo@lima.com',
	'Esse tema é muito relevante, obrigado por compartilhar!'
), (
	'2',
	'Fernanda Costa',
	'fernanda@costa.com',
	'Faltou um pouco mais de profundidade, mas bom conteúdo!'
), (
	'1',
	'Pedro Alves',
	'pedro@alves.com',
	'Muito bem escrito! Estou ansioso para mais posts.'
);

-- Visualizando as informações inseridas --

-- Mostra registros da tabela staff --
SELECT * FROM staff;
SELECT * FROM staff WHERE emp_name LIKE '%Lucas%';

-- Ordena em forma crescente (ASC) ou decrescente(DESC)
SELECT * FROM staff ORDER BY emp_name DESC;

-- Mostra registros da tabela article --
SELECT * FROM article;

-- Mostra registros da tabela comment --
SELECT * FROM comment;




