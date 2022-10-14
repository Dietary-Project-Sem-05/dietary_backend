const express = require("express");

const router = express.Router();

const userService = require("../services/userService");

router.post("/login", async (req, res) => {
  const result = await userService.signInUser(req.body);
  res.status(200);
  res.send(result);
});

module.exports = router;
