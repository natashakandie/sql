CREATE DATABASE bank_yangu;

USE bank_yangu;

CREATE TABLE accounts(account_number INT,full_name VARCHAR(20), birth_date DATE, address VARCHAR(50), email VARCHAR(50), phone VARCHAR(12), national_id_number INT UNIQUE, PRIMARY KEY(account_number));


CREATE TABLE transactions(transaction_id VARCHAR(6), amount INT, account_number INT, type ENUM('debit','credit'), PRIMARY KEY(transaction_id), FOREIGN KEY (account_number) REFERENCES accounts(account_number));

-- create two accounts for marion and ephraim
INSERT INTO accounts(account_number, full_name, birth_date, address, email, phone, national_id_number) VALUES (1001, 'Marion Jane', '1990-05-15', '123 Main St', 'marion.jane@gmail.com', '123-456-7890', 123456789);
INSERT INTO accounts(account_number, full_name, birth_date, address, email, phone, national_id_number) VALUES (1002, 'Ephraim John', '1985-10-20', '456 Elm St', 'ephraim@gmail.com', '987-654-3210', 987654321);

-- create transactions for marion and ephraim
INSERT INTO transactions(transaction_id, amount, account_number, type) VALUES ('T001', 500, 1001, 'credit');
INSERT INTO transactions(transaction_id, amount, account_number, type) VALUES ('T002', 200, 1001, 'debit');
INSERT INTO transactions(transaction_id, amount, account_number, type) VALUES ('T003', 1000, 1002, 'credit');