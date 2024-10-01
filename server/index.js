// index.js
const express = require("express");
const notesRoutes = require("./routes/notesRoutes");
const userRoutes = require("./routes/user.routes");
const app = express();
const port = 3000; // Change the port if necessary

// Define a simple route
app.get("/", (req, res) => {
    res.send("Hello World!");
});

// Middleware to parse JSON
app.use(express.json());

// Use the notes routes
app.use("/api/notes", notesRoutes);

// Use the user routes
app.use("/api/user", userRoutes);

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});
