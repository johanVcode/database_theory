--references needs the table to exist, so its reverse of the ERD made.
--so tables with no dependencies first

--uppgift 2 a)
CREATE TABLE member (
    medlemskaps_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    telefonnummer VARCHAR(50)
);

CREATE TABLE book(
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(50),
    ISBN VARCHAR(25)
);

CREATE TABLE exemplar(
    exemplar_id SERIAL PRIMARY KEY,
    book_id INT REFERENCES book(book_id)
);

CREATE TABLE loan (
    loan_id SERIAL PRIMARY KEY,
    medlemskaps_id INT REFERENCES member(medlemskaps_id),
    loan_date DATE, --not required by kravspec, added for tracking purposes
    due_date DATE

);

CREATE TABLE loan_item (
    loan_item_id SERIAL PRIMARY KEY,
    loan_id INT REFERENCES loan(loan_id),
    exemplar_id INT REFERENCES exemplar(exemplar_id),
    return_date DATE
);

-- uppgift 2b)

-- MEMBER (10 rows, includes matching first/last name pairs for realism)
INSERT INTO member (first_name, last_name, telefonnummer) VALUES
('Anna', 'Andersson', '0701234567'),
('Erik', 'Andersson', '0709876543'),    -- same surname, different first name
('Anna', 'Karlsson', '0761112233'),     -- same first name, different surname
('Johan', 'Berg', '0704455667'),
('Maria', 'Lind', '0709988776'),
('Karl', 'Nilsson', '0705566778'),
('Sara', 'Nilsson', '0708899001'),      -- same surname as above
('Oskar', 'Holm', '0707766554'),
('Emma', 'Sjöberg', '0703322110'),
('Lars', 'Persson', '0706677889');

-- BOOK (10 rows)
INSERT INTO book (title, author, isbn) VALUES
('Sagan om ringen', 'J.R.R. Tolkien', '9789100123456'),
('Harry Potter och de vises sten', 'J.K. Rowling', '9789100234567'),
('Snöleoparden', 'Jonas Karlsson', '9789100345678'),
('Slutet av avslut', 'Elin Cullhed', '9789100456789'),
('Norra Latin', 'Lena Andersson', '9789100567890'),
('Klara', 'David Lagercrantz', '9789100678901'),
('Doften av mörker', 'Camilla Läckberg', '9789100789012'),
('Snapphanarnas hämnd', 'Jan Guillou', '9789100890123'),
('Dimman', 'Åsa Larsson', '9789100901234'),
('Vinterviken', 'Mats Wahl', '9789101012345');

-- EXEMPLAR (10 rows, some books have 2 copies, some have 0)
INSERT INTO exemplar (book_id) VALUES
(1), (1),   -- Sagan om ringen: 2 copies
(2), (2), (2), -- Harry Potter: 3 copies (popular)
(3),
(4),
(5),
(6),
(7);
-- Books 8, 9, 10 intentionally have 0 copies (never acquired)

-- LOAN (10 rows, some members appear multiple times, some never)
INSERT INTO loan (medlemskaps_id, loan_date, due_date) VALUES
(1, '2026-08-01', '2026-08-31'),
(1, '2026-07-01', '2026-07-31'),   -- Anna Andersson borrowed twice
(2, '2026-08-10', '2026-09-09'),
(3, '2026-08-15', '2026-09-14'),
(4, '2026-07-20', '2026-08-19'),
(5, '2026-08-05', '2026-09-04'),
(6, '2026-08-20', '2026-09-19'),
(8, '2026-08-12', '2026-09-11'),
(9, '2026-07-25', '2026-08-24'),
(10, '2026-08-18', '2026-09-17');
-- Members 7 (Sara Nilsson) has never borrowed anything

-- LOAN_ITEM (10 rows, some returned, some still out = NULL)
INSERT INTO loan_item (loan_id, exemplar_id, return_date) VALUES
(1, 1, '2026-08-20'),
(2, 2, '2026-07-25'),
(3, 3, NULL),           -- still out
(4, 4, '2026-09-01'),
(5, 6, NULL),           -- still out
(6, 7, '2026-08-30'),
(7, 8, NULL),           -- still out
(8, 9, '2026-09-05'),
(9, 5, '2026-08-15'),
(10, 10, NULL);          -- still out
