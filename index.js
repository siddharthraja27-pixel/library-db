require('dotenv').config();
const express = require('express');
const { Pool } = require('pg');

const app = express();
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: { rejectUnauthorized: false }
});

// Root route
app.get('/', (req, res) => {
  res.send('Library API is running!');
});

// Get all books with author names
app.get('/api', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT b.id, b.title, a.name AS author, 
             b.genre, b.price, b.published_year
      FROM books b
      JOIN authors a ON b.author_id = a.id
    `);
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get all authors
app.get('/api/authors', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM authors');
    res.json(result.rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Get single book by ID
app.get('/api/books/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const result = await pool.query(
      'SELECT * FROM books WHERE id = $1', [id]
    );
    res.json(result.rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});