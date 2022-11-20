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

async function updateState(id, state) {
  try {
    const updateFood = await prisma.foodItem.update({
      where: {
        id: id,
      },
      data: {
        state: state,
      },
    });
    return updateFood;
  } catch (error) {
    throw error;
  }
}

module.exports = { getAllFoods, updateState };
