const jwt = require("jsonwebtoken");
const generateOutput = require("./generateOutput");

function generateAccessToken(data) {
  return jwt.sign(data, process.env.TOKEN_SECRET, {
    expiresIn: process.env.TOKEN_EXPIRE_TIME,
  });
}

function authenticateToken(req, res, next) {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];
  if (token == null) return res.sendStatus(401);

  jwt.verify(token, process.env.TOKEN_SECRET, (err, user) => {
    if (err) {
      res.status(403);
      res.send(generateOutput(403, "Unauthorized"));
      return;
    }

    req.user = user;

    next();
  });
}

module.exports = { generateAccessToken, authenticateToken };
