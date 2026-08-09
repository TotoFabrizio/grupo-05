const express = require("express");
const app = express();
const path = require("path");
const methodOverride = require("method-override");
const session = require("express-session");
const cookieParser = require("cookie-parser");

const userLoggedMiddleware = require("./middlewares/userLoggedMiddleware.js");

app.set("view engine", "ejs");
app.set("views", path.join(__dirname, "views"));

app.use(express.static(path.join(__dirname, "../public")));

app.use(methodOverride("_method"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(
    session({
        secret: "gaming",
        resave: false,
        saveUninitialized: false,
    }),
);

app.use(cookieParser());

const initDatabase = require("./database/initDatabase");

(async () => {
    try {
        await initDatabase();
    } catch (err) {
        console.error("No se pudo inicializar la base de datos:", err.message);
    }

    app.listen(3001, () => {
        console.log("server activo");
    });
})();

const mainRouter = require("./routes/main-router");
app.use(userLoggedMiddleware);

app.locals.toThousand = (n) =>
    n
        .toString()
        .replace(".", ",")
        .replace(/\B(?=(\d{3})+(?!\d))/g, ".");
app.use("/", mainRouter);
