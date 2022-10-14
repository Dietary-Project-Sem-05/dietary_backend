var createError = require("http-errors");
var express = require("express");
var path = require("path");
var cookieParser = require("cookie-parser");
var logger = require("morgan");
var cors = require("cors");

const port = process.env.PORT || 5000;

var app = express();

const userController = require("./src/controllers/userController");

app.use(cors());
app.use(logger("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use("/api/user", userController);

app.listen(port, () => {
  console.log(`Server successfully started on ${port}`);
});
