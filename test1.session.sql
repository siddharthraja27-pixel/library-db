DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;
CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200),
    author_id INT REFERENCES authors(id),
    genre VARCHAR(50),
    price DECIMAL(10,2),
    published_year INT
);

INSERT INTO authors (name, country) VALUES
('George Orwell', 'United Kingdom'),
('J.K. Rowling', 'United Kingdom'),
('Haruki Murakami', 'Japan'),
('Agatha Christie', 'United Kingdom'),
('Mark Twain', 'United States');

INSERT INTO books (title, author_id, genre, price, published_year) VALUES
('1984', 1, 'Dystopian', 9.99, 1949),
('Animal Farm', 1, 'Political Satire', 7.99, 1945),
('Harry Potter and the Sorcerers Stone', 2, 'Fantasy', 12.99, 1997),
('Norwegian Wood', 3, 'Romance', 11.99, 1987),
('Murder on the Orient Express', 4, 'Mystery', 8.99, 1934),
('The ABC Murders', 4, 'Mystery', 8.49, 1936),
('Adventures of Huckleberry Finn', 5, 'Adventure', 6.99, 1884);
-- Get all books
SELECT * FROM books;

-- Get all authors
SELECT * FROM authors;

-- Join books with author names
SELECT b.title, a.name AS author, b.genre, b.price
FROM books b
JOIN authors a ON b.author_id = a.id;

-- Books by a specific author
SELECT b.title, b.published_year
FROM books b
JOIN authors a ON b.author_id = a.id
WHERE a.name = 'Agatha Christie';

-- Books cheaper than $10
SELECT title, price FROM books
WHERE price < 10.00
ORDER BY price ASC;

-- Count books per author
SELECT a.name, COUNT(b.id) AS book_count
FROM authors a
LEFT JOIN books b ON a.id = b.author_id
GROUP BY a.name
ORDER BY book_count DESC;

-- Most expensive book
SELECT title, price FROM books
ORDER BY price DESC
LIMIT 1;

-- Books by genre
SELECT genre, COUNT(*) AS total
FROM books
GROUP BY genre
ORDER BY total DESC;
