const mysql = require("mysql2/promise");
const fs = require("fs");
const path = require("path");

const env = process.env.NODE_ENV || "development";
const config = require(path.join(__dirname, "config", "config.js"))[env];

async function initDatabase() {
    const username = config.username || process.env.DB_USER || "root";
    const password = config.password || process.env.DB_PASS || "";
    const host = config.host || process.env.DB_HOST || "127.0.0.1";

    const sqlPath = path.join(__dirname, "structure.sql");
    if (!fs.existsSync(sqlPath)) {
        console.log("structure.sql no encontrado en", sqlPath);
        return;
    }

    const sql = fs.readFileSync(sqlPath, "utf8");

    let connection;
    try {
        connection = await mysql.createConnection({
            host,
            user: username,
            password,
            multipleStatements: true,
        });

        await connection.query(sql);
        console.log("Ejecución de structure.sql completada.");
    } catch (err) {
        console.error("Error al ejecutar structure.sql:", err.message);
        throw err;
    } finally {
        if (connection && connection.end) await connection.end();
    }
}

module.exports = initDatabase;
