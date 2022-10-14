const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();

async function getUser(email) {
  try {
    const user = await prisma.user.findUnique({
      where: { email: email },
    });
    return user;
  } catch (error) {
    throw error;
  }
}

module.exports = { getUser };
