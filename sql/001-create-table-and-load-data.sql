DROP TABLE IF EXISTS movies;

CREATE TABLE movies (
  id int unsigned AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  director VARCHAR(100) NOT NULL,
  PRIMARY KEY(id)
);

INSERT INTO movies (name, director) VALUES ("ショーシャンクの空に", "フランク・ダラボン");
INSERT INTO movies (name, director) VALUES ("この世界の片隅に", "片渕須直");
