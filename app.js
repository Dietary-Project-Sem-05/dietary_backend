require("dotenv").config();
const createError = require("http-errors");
const express = require("express");
const path = require("path");
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const logger = require("morgan");
const cors = require("cors");

const app = express();

const userController = require("./src/controllers/userController");
const foodController = require("./src/controllers/foodController");

app.use(cors());
app.use(logger("dev"));
app.use(cookieParser());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use("/api/user", userController);
app.use("/api/food", foodController);

app.get("/", (req, res) => {
  res.status(200).send("Server is working");
});

const port = process.env.PORT || 5000;

app.listen(port, () => {
  console.log(`Server successfully started on ${port}`);
});
