const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();

async function getUser(email) {
  try {
    const user = await prisma.moderator.findUnique({
      where: { email: email },
    });
    return user;
  } catch (error) {
    throw error;
  }
}

async function registerUser(data) {
  try {
    const user = await prisma.moderator.create({ data: { ...data } });
    delete user["password"];
    console.log(user);
    return user;
  } catch (error) {
    throw error;
  }
}

async function getAllUser(data) {
  try {
    const user = await prisma.moderator.findMany({
      where: { email: email },
    });
    return user;
  } catch (error) {
    throw error;
  }
}

module.exports = { getUser, registerUser };
