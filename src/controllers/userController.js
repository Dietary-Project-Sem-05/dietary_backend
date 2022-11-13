const express = require("express");
const { authenticateToken } = require("../helpers/accessToken");

const router = express.Router();

const userService = require("../services/userService");

router.get("/", authenticateToken, (req, res) => {
  res.status(200);
  res.send("Check");
});

router.post("/login", async (req, res) => {
  const result = await userService.signInUser(req.body);
  res.status(200);
  res.send(result);
});

module.exports = router;
