const bcrypt = require("bcrypt");
const generateOutput = require("../helpers/generateOutput");
const userRepository = require("../repositories/userRepository");
const { generateAccessToken } = require("../helpers/accessToken");
const {
  userLogInSchema,
  userRegisterSchema,
} = require("../validationSchemas/userSchema");
const { func } = require("joi");

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

async function registerUser(data) {
  try {
    await userRegisterSchema.validateAsync({ ...data });
  } catch (error) {
    return generateOutput(401, "Validation error!");
  }
  return new Promise(async (resolve, reject) => {
    bcrypt.hash(data.password, 10, async function (err, hash) {
      if (err) {
        resolve(generateOutput(400, "Server error!"));
      }
      try {
        const user = await userRepository.registerUser({
          ...data,
          password: hash,
        });
        console.log(user);
        resolve(
          generateOutput(201, {
            user,
            token: generateAccessToken({
              id: user.moderatorId,
              email: user.email,
            }),
          })
        );
      } catch (error) {
        resolve(generateOutput(500, "Error in creating user"));
      }
    });
  });
}

async function getUsers() {
  try {
    const allUsers = await userRepository.getAllUsers();
    return generateOutput(200, allUsers);
  } catch (error) {
    return generateOutput(500, "Error in getting Users");
  }
}

async function removeUser(email) {
  if (!email) {
    return generateOutput(400, "Invalid request");
  }
  try {
    const user = await userRepository.removeUser(email);
    return generateOutput(200, user);
  } catch (error) {
    return generateOutput(500, "Error in removing user");
  }
}

async function updateUserActive(email, isActive) {
  try {
    const updatedUser = await userRepository.updateIsActive(email, isActive);
    return generateOutput(200, updatedUser);
  } catch (error) {
    return generateOutput(500, "Error in updating user");
  }
}

module.exports = {
  signInUser,
  registerUser,
  getUsers,
  removeUser,
  updateUserActive,
};
