-- Creazione dell'utente con privilegi principali
CREATE USER 'admin_visualcue'@'localhost' IDENTIFIED BY 'securepassword';
GRANT CREATE, ALTER, DROP, INSERT, UPDATE, DELETE, SELECT, EXECUTE ON visualcue.* TO 'admin_visualcue'@'localhost';
FLUSH PRIVILEGES;

CREATE DATABASE visualcue;
USE visualcue;

CREATE TABLE user (
    email VARCHAR(255) PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    password CHAR(60) NOT NULL,
    is_banned BOOLEAN DEFAULT FALSE
);

CREATE TABLE type_test (
    name VARCHAR(255) PRIMARY KEY
);

CREATE TABLE test (
    test_id INT PRIMARY KEY AUTO_INCREMENT,
    score INT NOT NULL,
    user_email VARCHAR(255),
    type_test_name VARCHAR(255),
    FOREIGN KEY (user_email) REFERENCES user(email) ON DELETE CASCADE,
    FOREIGN KEY (type_test_name) REFERENCES type_test(name) ON DELETE CASCADE
);

CREATE TABLE collection (
    collection_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    is_public BOOLEAN DEFAULT TRUE,
    image VARCHAR(255),
    user_email VARCHAR(255),
    FOREIGN KEY (user_email) REFERENCES user(email) ON DELETE CASCADE
);

CREATE TABLE card (
    card_id INT PRIMARY KEY AUTO_INCREMENT,
    text VARCHAR(255) NOT NULL,
    image VARCHAR(255),
    collection_id INT,
    FOREIGN KEY (collection_id) REFERENCES collection(collection_id) ON DELETE CASCADE,
    UNIQUE (collection_id, text)
);

CREATE TABLE collection_test (
    collection_id INT,
    test_id INT,
    PRIMARY KEY (collection_id, test_id),
    FOREIGN KEY (collection_id) REFERENCES collection(collection_id) ON DELETE CASCADE,
    FOREIGN KEY (test_id) REFERENCES test(test_id) ON DELETE CASCADE
);