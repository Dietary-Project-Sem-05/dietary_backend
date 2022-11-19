const express = require("express");
const { authenticateToken } = require("../helpers/accessToken");

const router = express.Router();

const userService = require("../services/userService");

router.get("/moderator/dashboard", authenticateToken, (req, res) => {
  res.status(200);
  res.send("Check");
});

router.post("/login", async (req, res) => {
  const result = await userService.signInUser(req.body);
  res.status(200);
  res.send(result);
});

router.post("/admin/add-moderator", async (req, res) => {
  const result = await userService.registerUser(req.body);
  res.status(200);
  res.send(result);
});

router.get("/admin/mod-info", async (req, res) => {
  const result = await userService.getUsers(req.body);
  res.status(200);
  res.send(result);
});

router.delete("/admin/mod-info", async (req, res) => {
  const result = await userService.removeUser(req.body.email);
  res.status(200);
  res.send(result);
});

module.exports = router;
