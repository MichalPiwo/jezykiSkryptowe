CREATE USER docker;
CREATE DATABASE docker;
USE docker;
CREATE TABLE user (FirstName varchar(255), LastName varchar(255), PESEL VARCHAR(11) NOT NULL PRIMARY KEY, UserName VARCHAR(255), Password VARCHAR(255));
INSERT INTO user (FirstName, LastName, PESEL, UserName, Password) VALUES ("Jan", "Kowalski", "01234567891", "jan", "haslo");

CREATE TABLE category ( id INT NOT NULL AUTO_INCREMENT, name VARCHAR(50) NOT NULL, PRIMARY KEY (id));

CREATE TABLE product ( id INT NOT NULL, name VARCHAR(50) NOT NULL, description TEXT NOT NULL, category INT NOT NULL, price INT NOT NULL, FOREIGN KEY(category) references category(id) );

INSERT INTO category (id, name) VALUES (1, "uroda");
INSERT INTO category (id, name) VALUES(2, "jedzenie");
INSERT INTO category (id, name) VALUES(3, "obuwie");

INSERT INTO product (id, name, description, category, price) VALUES (1, "mydlo", "super mydlo ", 1, 11);
INSERT INTO product (id, name, description, category, price) VALUES (2, "powidlo", "ekologiczne powidlo", 2, 22);
INSERT INTO product (id, name, description, category, price) VALUES (3, "szwarc", "do czarnych butow", 3, 33);

