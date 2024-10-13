// notesController.js
const pool = require("../db"); // Assumes you're using a PostgreSQL pool connection

// Create a new note
const createNote = async (req, res) => {
    const { id, postTitle, postBody, imageUrl, publicPost, likes, ownerId } =
        req.body;
    try {
        const newNote = await pool.query(
            "INSERT INTO notes (id, postTitle, postBody, imageUrl, publicPost, likes, ownerId) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *",
            [id, postTitle, postBody, imageUrl, publicPost, likes, ownerId]
        );
        res.json(newNote.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

// Get all notes
const getNotes = async (req, res) => {
    try {
        const notes = await pool.query("SELECT * FROM notes");
        res.json(notes.rows);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

// Get a single note by ID
const getNoteById = async (req, res) => {
    const { id } = req.params;
    try {
        const note = await pool.query("SELECT * FROM notes WHERE id = $1", [
            id,
        ]);
        if (note.rows.length === 0) {
            return res.status(404).json({ message: "Note not found" });
        }
        res.json(note.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

// Update a note
const updateNote = async (req, res) => {
    const { id } = req.params;
    const { title, content } = req.body;
    try {
        const updatedNote = await pool.query(
            "UPDATE notes SET title = $1, content = $2 WHERE id = $3 RETURNING *",
            [title, content, id]
        );
        if (updatedNote.rows.length === 0) {
            return res.status(404).json({ message: "Note not found" });
        }
        res.json(updatedNote.rows[0]);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

// Delete a note
const deleteNote = async (req, res) => {
    const { id } = req.params;
    try {
        const deletedNote = await pool.query(
            "DELETE FROM notes WHERE id = $1 RETURNING *",
            [id]
        );
        if (deletedNote.rows.length === 0) {
            return res.status(404).json({ message: "Note not found" });
        }
        res.json({ message: "Note deleted" });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

module.exports = {
    createNote,
    getNotes,
    getNoteById,
    updateNote,
    deleteNote,
};
