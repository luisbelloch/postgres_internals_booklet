drop table compra;

CREATE TABLE compra (
  usuario varchar(15) NOT NULL,
  libro varchar(15) NOT NULL,
  precio money NOT NULL,
  CONSTRAINT pk_compra PRIMARY KEY (usuario, libro),
  CONSTRAINT fk_compra_usuario FOREIGN KEY (usuario) REFERENCES usuario(login),
  CONSTRAINT fk_compra_libro FOREIGN KEY (libro) REFERENCES libro(isbn)
);

INSERT INTO COMPRA (usuario, libro, precio) VALUES ('mike', '9781593272838', '15.99');
SELECT t_xmin, t_xmax FROM heap_page_items(get_raw_page('compra', 0));

DELETE FROM compra;
INSERT INTO COMPRA (usuario, libro, precio) VALUES ('mike', '9781593272838', '15.99');
SELECT t_xmin, t_xmax FROM heap_page_items(get_raw_page('compra', 0));

BEGIN WORK;
DELETE FROM compra;
SELECT xmin, xmax, * FROM compra;
\! psql -h localhost -d biblioteca -e -c "SELECT xmin, xmax, * FROM compra;"
SELECT txid_current();
COMMIT WORK;