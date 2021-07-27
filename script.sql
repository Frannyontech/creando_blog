DROP DATABASE blog;

CREATE DATABASE blog;

\c blog

CREATE TABLE usuarios(
    id SERIAL NOT NULL PRIMARY KEY,
    email VARCHAR(50)
);

CREATE TABLE posts(
    id SERIAL NOT NULL PRIMARY KEY,
    usuario_id INT,
    titulo VARCHAR(200),
    fecha DATE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE comentarios(
    id SERIAL NOT NULL PRIMARY KEY,
    usuario_id INT,
    post_id INT,
    texto VARCHAR(200),
    fecha DATE,
    FOREIGN KEY (post_id) REFERENCES posts(id),
    FOREIGN KEY (usuario_id)REFERENCES usuarios(id)
);

\copy usuarios FROM 'usuarios.csv' csv;
\copy posts FROM 'posts.csv' csv ;
\copy comentarios FROM 'comentarios.csv' csv; 

--4. Seleccionar el correo, id y título de todos los post publicados por el usuario 5.
SELECT usuarios.id, usuarios.email, posts.titulo, FROM usuarios
INNER JOIN posts 
ON usuarios.id = posts.usuario_id
WHERE usuarios.id = 5;

--5. Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados
-- por el usuario con email ​usuario06@hotmail.com​.
SELECT usuarios.email, comentarios.id, comentarios.texto 
FROM usuarios INNER JOIN comentarios 
ON usuarios.id = comentarios.usuario_id 
WHERE usuarios.email != 'usuario06@hotmail.com';

-- 6. Listar los usuarios que no han publicado ningún post.
SELECT usuarios.email FROM usuarios LEFT JOIN posts ON usuarios.id = posts.usuario_id
WHERE posts.usuario_id IS NULL;

-- 7. Listar todos los post con sus comentarios (incluyendo aquellos que no poseen
-- comentarios).
SELECT * FROM posts FULL OUTER JOIN comentarios 
ON posts.id = comentarios.post_id;

-- 8. Listar todos los usuarios que hayan publicado un post en Junio
SELECT usuarios.email, posts.fecha FROM usuarios 
INNER JOIN posts 
ON usuarios.id = posts.usuario_id
WHERE EXTRACT(MONTH FROM posts.fecha) = 6;
