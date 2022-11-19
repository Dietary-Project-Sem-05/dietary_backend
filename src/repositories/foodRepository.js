const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();

async function getAllFoods() {
  try {
    const allFoods = await prisma.foodItem.findMany();
    return allFoods;
  } catch (error) {
    throw error;
  }
}

module.exports = { getAllFoods };
