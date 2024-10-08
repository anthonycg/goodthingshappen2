const { Pool } = require("pg");

// Create a new connection pool
const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT, // Postgres default port
});

// Export the pool for use in your controllers
module.exports = pool;
