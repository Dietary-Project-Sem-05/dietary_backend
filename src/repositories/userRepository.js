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
    return user;
  } catch (error) {
    throw error;
  }
}

async function getAllUsers() {
  try {
    const allUsers = await prisma.moderator.findMany();
    return allUsers;
  } catch (error) {
    throw error;
  }
}

async function removeUser(email) {
  try {
    const user = await prisma.moderator.delete({
      where: { email: email },
    });
    return user;
  } catch (error) {
    throw error;
  }
}
module.exports = { getUser, registerUser, getAllUsers, removeUser };
