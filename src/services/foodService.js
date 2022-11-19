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

async function updateNewState(id, state) {
  try {
    const updatedFood = await foodRepository.updateState(id, state);
    return generateOutput(200, updatedFood);
  } catch (error) {
    return generateOutput(500, "Error in updating food");
  }
}

module.exports = { getFoods, updateNewState };
