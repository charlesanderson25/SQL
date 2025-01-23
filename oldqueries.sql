CREATE TABLE `NOTEPADS` (
`ID` INT UNSIGNED NOT NULL,
`TITLE` VARCHAR(255) NOT NULL,
`SUBTITLE` VARCHAR(255) NOT NULL,
`CONTENT` TEXT NOT NULL,
PRIMARY KEY (ID)
)
;

ALTER TABLE notepads MODIFY COLUMN id INT UNSIGNED NOT NULL AUTO_INCREMENT;

INSERT INTO notepads (title, subtitle, content) VALUES ('Titulo 2', 'Subtitulo 2', 'Conteúdo 2') RETURNING *;

ALTER TABLE notepads ADD `created_at` timestamp DEFAULT CURRENT_TIMESTAMP;

DELETE FROM notepads WHERE id = 1;

UPDATE notepads
SET 
title = ?,
subtitle = ?,
content = ?
WHERE id = ?;

CREATE TABLE posts AS SELECT * FROM notepads;

ALTER TABLE posts DROP COLUMN title, DROP COLUMN subtitle;

ALTER TABLE posts MODIFY id INT AUTO_INCREMENT;
ALTER TABLE posts ADD PRIMARY KEY (id);

CREATE TABLE comments (
id INT,
message TEXT NOT NULL, 
created_at TIMESTAMP,
post_id INT NOT NULL
)

ALTER TABLE comments ADD PRIMARY KEY (id);
ALTER TABLE comments MODIFY id INT AUTO_INCREMENT;
ALTER TABLE comments MODIFY created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE comments ADD CONSTRAINT FK_comments_post FOREIGN KEY (post_id) REFERENCES posts (id);
ALTER TABLE comments ADD CONSTRAINT FK_comments_post FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE cascade;

INSERT INTO comments (message, post_id) VALUES ('Teste 1', 1);

CREATE TABLE users(
id INT, 
first_name VARCHAR(255) NOT NULL,
last_name VARCHAR(255) NOT NULL,
avatar VARCHAR(2048) NOT NULL,
pass_word VARCHAR(255) NOT NULL, 
created_at TIMESTAMP
)

ALTER TABLE users ADD PRIMARY KEY (id);
ALTER TABLE users MODIFY id INT AUTO_INCREMENT;
ALTER TABLE users MODIFY created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE posts ADD COLUMN user_id INT REFERENCES users(id);
ALTER TABLE comments ADD COLUMN user_id INT REFERENCES users(id);

DELETE FROM comments;
DELETE FROM posts;

SELECT 
posts.id,
posts.content,
posts.created_at, 
posts.user_id,
users.first_name,
users.last_name, 
users.avatar
FROM posts
INNER JOIN users ON posts.user_id = users.id
ORDER BY posts.id DESC;

Select 
        comments.id,
        comments.message,
        comments.created_at, 
        comments.user_id,
        users.first_name as user_first_name,
        users.last_name as user_last_name, 
        users.avatar as user_avatar 
      from comments inner join users on comments.user_id = users.id
      order by comments.created_at DESC;
      
CREATE TABLE friends (
id INT,
user_a INT NOT NULL,
user_b INT NOT NULL
);

ALTER TABLE friends ADD PRIMARY KEY (id);
ALTER TABLE friends MODIFY id INT AUTO_INCREMENT;
ALTER TABLE friends ADD CONSTRAINT fk_user_a FOREIGN KEY (user_a) REFERENCES users(id) ON DELETE CASCADE;
ALTER TABLE friends ADD CONSTRAINT fk_user_b FOREIGN KEY (user_b) REFERENCES users(id) ON DELETE CASCADE;

SELECT * FROM users WHERE id IN(
SELECT user_b
FROM friends
WHERE user_a = 1
UNION 
SELECT user_a
FROM friends
WHERE user_b = 1
)

ORDER BY created_at DESC
LIMIT 9;