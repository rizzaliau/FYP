CREATE DATABASE `is203`;
USE `is203`;


CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL auto_increment,
  `name` varchar(150)  NOT NULL,
  `password` varchar(50)  NOT NULL,
  `gender` varchar(1)  NOT NULL,
  PRIMARY KEY  (`id`)
);


INSERT INTO `user` (`id`, `name`, `password`, `gender`) VALUES (1, 'rajesh', '12345', 'M');
INSERT INTO `user` (`id`, `name`, `password`, `gender`) VALUES (2, 'yeowleong', '54321', 'M');
