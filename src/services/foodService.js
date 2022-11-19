const foodRepository = require("../repositories/foodRepository");
const generateOutput = require("../helpers/generateOutput");

async function getFoods() {
  try {
    const allFoods = await foodRepository.getAllFoods();
    return generateOutput(200, allFoods);
  } catch (error) {
    return generateOutput(500, "Error in getting Food Items");
  }
}

module.exports = { getFoods };
