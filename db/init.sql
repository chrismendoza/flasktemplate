CREATE DATABASE IF NOT EXISTS `apatest`;
use `apatest`;

CREATE TABLE pets (
  `name` VARCHAR(20),
  `type` ENUM('dog', 'cat'),
  `color` VARCHAR(25),
  `age` TINYINT UNSIGNED
);

INSERT INTO pets
  (`name`, `type`, `color`, `age`)
VALUES
  ('Carley', 'dog', 'brown/white', 12),
  ('Wiggles', 'dog', 'black/white', 15),
  ('Gizmo', 'cat', 'calico', 18);