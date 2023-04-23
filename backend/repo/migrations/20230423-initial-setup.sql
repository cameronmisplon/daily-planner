create database daily_planner;
use daily_planner;

create table users (
	`id`			INT(11)				NOT NULL 		AUTO_INCREMENT,
    `username`  	VARCHAR(255)		NOT NULL,
    `created_at`	TIMESTAMP			DEFAULT CURRENT_TIMESTAMP,
    `updated_at`	TIMESTAMP			DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(`id`)
);

create table daily_entries (
	`id`				INT(11)				NOT NULL 		AUTO_INCREMENT,
    `user_id`  			INT(11)				NOT NULL,
    `initiation_date`   DATETIME			NOT NULL,
    `frequency`	INT(11)				NOT NULL,
    `recurring`	INT(11)				NOT NULL,
    `created_at`		TIMESTAMP			DEFAULT CURRENT_TIMESTAMP,
    `updated_at`		TIMESTAMP			DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(`id`),
    FOREIGN KEY(`user_id`) REFERENCES users(`id`)
);

insert into users (username) values ("Kiana");
insert into users (username) values ("Cameron");