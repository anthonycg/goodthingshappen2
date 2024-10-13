const db = require("../db"); // Import the db module

// User controller

// Create a new user
const createUser = async (req, res) => {
    const {
        id,
        firebaseId,
        name,
        email,
        gender,
        profileImg,
        createdAt,
        updatedAt,
    } = req.body;

    const queryText = `
        INSERT INTO users (id, firebseId, name, email, gender, profileImg, createdAt, updatedAt)
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
        RETURNING *;`;

    try {
        const result = await db.query(queryText, [
            id,
            firebaseId,
            name,
            email,
            gender,
            profileImg,
            createdAt,
            updatedAt,
        ]);
        res.status(201).json(result.rows[0]); // Return the newly created user
    } catch (err) {
        res.status(400).json({
            error: "Error creating user",
            details: err.message,
        });
    }
};

// Get a user by ID
const getUser = async (req, res) => {
    const userId = req.params.id;

    const queryText = `
        SELECT * FROM users WHERE id = $1;`;

    try {
        const result = await db.query(queryText, [userId]);
        if (result.rows.length > 0) {
            res.json(result.rows[0]); // Return the found user
        } else {
            res.status(404).json({ error: "User not found" });
        }
    } catch (err) {
        res.status(400).json({
            error: "Error retrieving user",
            details: err.message,
        });
    }
};

// Update a user by ID
const updateUser = async (req, res) => {
    const userId = req.params.id;
    const { name, email, gender, profileImg, updatedAt } = req.body;

    const queryText = `
        UPDATE users SET name = $1, email = $2, gender = $3, profileImg = $4, updatedAt = $5
        WHERE id = $6
        RETURNING *;`;

    try {
        const result = await db.query(queryText, [
            name,
            email,
            gender,
            profileImg,
            updatedAt,
            userId,
        ]);
        if (result.rows.length > 0) {
            res.json(result.rows[0]); // Return the updated user
        } else {
            res.status(404).json({ error: "User not found" });
        }
    } catch (err) {
        res.status(400).json({
            error: "Error updating user",
            details: err.message,
        });
    }
};

// Delete a user by ID
const deleteUser = async (req, res) => {
    const userId = req.params.id;

    const queryText = `
        DELETE FROM users WHERE id = $1 RETURNING *;`;

    try {
        const result = await db.query(queryText, [userId]);
        if (result.rows.length > 0) {
            res.json({ message: "User deleted", user: result.rows[0] }); // Confirm deletion
        } else {
            res.status(404).json({ error: "User not found" });
        }
    } catch (err) {
        res.status(400).json({
            error: "Error deleting user",
            details: err.message,
        });
    }
};

module.exports = {
    createUser,
    getUser,
    updateUser,
    deleteUser,
};
