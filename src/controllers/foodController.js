const express = require("express");
const router = express.Router();

const foodService = require("../services/foodService");

router.get("/moderator/dashboard", async (req, res) => {
  const result = await foodService.getFoods(req.body);
  res.status(200);
  res.send(result);
});

router.post("/moderator/dashboard", async (req, res) => {
  const result = await foodService.updateNewState(req.body.id, req.body.state);
  res.status(200);
  res.send(result);
});

module.exports = router;
