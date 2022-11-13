const Joi = require("joi");

const userLogInSchema = Joi.object({
  email: Joi.string().email().max(255).required(),
  password: Joi.string()
    .regex(/\d+/, "Password should contain at least one number")
    .regex(/[a-z]+/, "Password should contain at least one lowercase character")
    .regex(
      /[A-Z]+/,
      "Passoword should contain at least one uppercase character"
    )
    .regex(
      /[!@#$%^&*()-+]+/,
      "Password should contain at least one special character"
    ),
});

module.exports = {
  userLogInSchema,
};
