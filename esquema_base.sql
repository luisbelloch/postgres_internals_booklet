CREATE DATABASE biblioteca;
\c biblioteca

CREATE TABLE almacen (
  id integer NOT NULL,
  nombre varchar(50) NOT NULL,
  CONSTRAINT pk_almacen PRIMARY KEY (id)
);

INSERT INTO almacen (id, nombre) VALUES
(0, 'Central'),
(1, 'Norte');

CREATE TABLE libro (
  isbn varchar(15) NOT NULL,
  titulo varchar(512) NOT NULL,
  autor varchar(512) NOT NULL,
  stock int NOT NULL CONSTRAINT df_libro_stock DEFAULT 0,
  almacen int NOT NULL CONSTRAINT df_libroalmacen DEFAULT 0,
  CONSTRAINT pk_libro PRIMARY KEY (isbn),
  CONSTRAINT ck_libro_stock CHECK (stock >= 0),
  CONSTRAINT fk_libro_almacen FOREIGN KEY (almacen) REFERENCES almacen(id)
);

COPY libro (isbn, titulo, autor, stock) FROM STDIN WITH DELIMITER '|';
9781593272838|Learn You a Haskell for Great Good!|Miran Lipovača|10
0521692695|Programming in Haskell|Graham Hutton|10
\.

CREATE TABLE usuario (
  login varchar(15) NOT NULL,
  nombre varchar(256) NOT NULL,
  CONSTRAINT pk_usuario PRIMARY KEY (login)
);

INSERT INTO usuario (login, nombre) VALUES
('mike', 'Mike Wazowski'),
('jack', 'Jack Sparrow');

CREATE TABLE voto (
  usuario varchar(15) NOT NULL,
  libro varchar(15) NOT NULL,
  positivo boolean NOT NULL CONSTRAINT df_voto_positivo DEFAULT TRUE,
  CONSTRAINT pk_voto PRIMARY KEY (usuario, libro, positivo),
  CONSTRAINT fk_voto_usuario FOREIGN KEY (usuario) REFERENCES usuario(login),
  CONSTRAINT fk_voto_libro FOREIGN KEY (libro) REFERENCES libro(isbn)
);

INSERT INTO voto (usuario, libro, positivo) VALUES
('mike', '9781593272838', 't'),
('jack', '9781593272838', 't'),
('jack', '0521692695', 'f');

CREATE TABLE compra (
  usuario varchar(15) NOT NULL,
  libro varchar(15) NOT NULL,
  precio money NOT NULL,
  CONSTRAINT pk_compra PRIMARY KEY (usuario, libro),
  CONSTRAINT fk_compra_usuario FOREIGN KEY (usuario) REFERENCES usuario(login),
  CONSTRAINT fk_compra_libro FOREIGN KEY (libro) REFERENCES libro(isbn)
);

