const { Pool } = require("pg");

// Create a new connection pool
const pool = new Pool({
    user: "me",
    host: "157.245.141.30",
    database: "goodThingsHappenDB",
    password: "Agagag24!",
    port: 5432, // Postgres default port
});

// Export the pool for use in your controllers
module.exports = pool;
