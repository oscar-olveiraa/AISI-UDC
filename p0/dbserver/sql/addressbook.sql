CREATE TABLE IF NOT EXISTS address (id INT(4) NOT NULL AUTO_INCREMENT PRIMARY KEY, lastname VARCHAR(30), firstname VARCHAR(30), phone VARCHAR(30), email VARCHAR(30));
INSERT IGNORE INTO address (lastname, firstname, phone, email) VALUES ( "Johnson", "Roberto", "123-456-7890", "robertoj@someaddress.com"), ( "Doe", "Jane", "010-110-1101", "janed@someotheraddress.org" );
GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.56.%' IDENTIFIED BY 'root' WITH GRANT OPTION;
SELECT * FROM address;
