const mysql = require("mysql2/promise");
const fs = require("fs");
const path = require("path");

const env = process.env.NODE_ENV || "development";
const config = require(path.join(__dirname, "config", "config.js"))[env];

async function initDatabase() {
    const username = config.username || process.env.DB_USER || "root";
    const password = config.password || process.env.DB_PASS || "";
    const host = config.host || process.env.DB_HOST || "127.0.0.1";
    const port = config.port || process.env.DB_PORT || 3306;
    const targetDb = process.env.DB_NAME || config.database || "hard4gamers";

    const sqlPath = path.join(__dirname, "structure.sql");
    if (!fs.existsSync(sqlPath)) {
        console.log("structure.sql no encontrado en", sqlPath);
        return;
    }

    let sql = fs.readFileSync(sqlPath, "utf8");

    // Remove explicit DROP/CREATE/USE statements so we can apply the SQL to chosen DB
    sql = sql.replace(
        /DROP\s+DATABASE\s+IF\s+EXISTS\s+[`'" ]*[\w-]+[`'" ]*\s*;?/gi,
        "",
    );
    sql = sql.replace(/CREATE\s+DATABASE[\s\S]*?;+/gi, "");
    sql = sql.replace(/USE\s+[`'" ]*[\w-]+[`'" ]*\s*;?/gi, "");

    let connection;
    try {
        connection = await mysql.createConnection({
            host,
            user: username,
            password,
            port,
            multipleStatements: true,
        });

        // Ensure database exists
        await connection.query(
            `CREATE DATABASE IF NOT EXISTS \`${targetDb}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;`,
        );

        // If DB already has tables, skip to avoid duplicate inserts
        const [rows] = await connection.query(
            "SELECT COUNT(*) AS cnt FROM information_schema.tables WHERE table_schema = ?;",
            [targetDb],
        );
        if (rows && rows[0] && rows[0].cnt > 0) {
            console.log(
                `Base de datos \`${targetDb}\` ya contiene tablas (cnt=${rows[0].cnt}), se omite la ejecución de structure.sql.`,
            );
            return;
        }

        // Execute the remaining SQL within the target DB
        await connection.query(`USE \`${targetDb}\`; ${sql}`);
        console.log(
            `Ejecución de structure.sql completada en la base \`${targetDb}\`.`,
        );
    } catch (err) {
        console.error("Error al ejecutar structure.sql:", err.message);
        throw err;
    } finally {
        if (connection && connection.end) await connection.end();
    }
}

module.exports = initDatabase;
