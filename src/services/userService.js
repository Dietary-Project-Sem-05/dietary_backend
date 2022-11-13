const bcrypt = require("bcrypt");
const generateOutput = require("../helpers/generateOutput");
const userRepository = require("../repositories/userRepository");
const { generateAccessToken } = require("../helpers/accessToken");
const { userLogInSchema } = require("../validationSchemas/userSchema");

async function signInUser(data) {
  if (!data) {
    return generateOutput(400, "Invalid request");
  }
  try {
    await userLogInSchema.validateAsync({ ...data });
  } catch (error) {
    return generateOutput(401, "Validation error!");
  }

  try {
    const user = await userRepository.getUser(data.email);
    if (!user) {
      return generateOutput(400, "User not found");
    }
    return new Promise((resolve, reject) => {
      bcrypt.compare(data.password, user.password, function (err, result) {
        if (result) {
          const modiUser = { ...user };
          delete modiUser["password"];
          resolve(
            generateOutput(200, {
              user: modiUser,
              token: generateAccessToken({ id: user.id, email: user.email }),
            })
          );
        } else {
          resolve(generateOutput(400, "Invalid username or password"));
        }
      });
    });
  } catch (error) {
    console.log("Error occured: ", error);
    return generateOutput(400, "Error in getting the user");
  }
}

module.exports = { signInUser };
