// notesRoutes.js
const express = require("express");
const notesController = require("../controller/note.controller");
const router = express.Router();

// Route for creating a new note
router.post("/create", notesController.createNote);

// Route for getting all notes
router.get("/", notesController.getNotes);

// Route for getting a single note by ID
router.get("/:id", notesController.getNoteById);

// Route for updating a note
router.put("/:id", notesController.updateNote);

// Route for deleting a note
router.delete("/:id", notesController.deleteNote);

module.exports = router;
