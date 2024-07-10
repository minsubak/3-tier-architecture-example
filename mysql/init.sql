-- Create database if not exists
CREATE DATABASE IF NOT EXISTS world;

-- Switch to the 'world' database
USE world;

-- Create the 'member' table
CREATE TABLE IF NOT EXISTS member (
    no INT NOT NULL,
    t_name VARCHAR(20),
    content TEXT
);

-- Insert data into the 'member' table
INSERT INTO member VALUES
    (1, 'kim' , 'kim1111@naver.com'),
    (2, 'an'  , 'an2222@yahoo.com'),
    (3, 'baek', 'baek3333@gmail.com'),
    (4, 'choi', 'choi4444@daum.net'),
    (5, 'park', 'park5555@github.io'),
    (6, 'lee' , 'lee6666@zum.com');

-- Create a new database user
CREATE USER '${DB_USERNAME}'@'%' IDENTIFIED BY '${DB_PASSWORD}';

-- Grant all privileges on the 'world' database to the new user
GRANT ALL PRIVILEGES ON world.* TO '${DB_USERNAME}'@'%';
