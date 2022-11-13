-- CreateEnum
CREATE TYPE "Role" AS ENUM ('USER', 'ADMIN', 'MODERATOR');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE', 'OTHER');

-- CreateTable
CREATE TABLE "GeneralUser" (
    "id" SERIAL NOT NULL,
    "dateOfBirth" TIMESTAMP(3),
    "gender" "Gender",
    "weight" INTEGER,
    "height" INTEGER,
    "activityTime" VARCHAR(255) NOT NULL,
    "goalType" VARCHAR(255) NOT NULL,
    "dietGoal" VARCHAR(255) NOT NULL,
    "medicalConditions" VARCHAR(255) NOT NULL,
    "startingDate" TIMESTAMP(3),
    "preferedTime" TIMESTAMP(3),

    CONSTRAINT "GeneralUser_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Account" (
    "accountId" SERIAL NOT NULL,
    "accountNo" INTEGER NOT NULL,
    "userType" "Role" NOT NULL DEFAULT 'USER',
    "firstName" VARCHAR(255) NOT NULL,
    "lastName" VARCHAR(255) NOT NULL,
    "username" TEXT NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("accountId")
);

-- CreateTable
CREATE TABLE "Moderator" (
    "moderatorId" SERIAL NOT NULL,
    "telephoneNo" VARCHAR(255) NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Moderator_pkey" PRIMARY KEY ("moderatorId")
);

-- CreateTable
CREATE TABLE "UserGoal" (
    "goalId" SERIAL NOT NULL,
    "accountNo" INTEGER NOT NULL,
    "startDate" TIMESTAMP(3),
    "startWeight" INTEGER,
    "endDate" TIMESTAMP(3),
    "endWeight" INTEGER,
    "state" INTEGER,

    CONSTRAINT "UserGoal_pkey" PRIMARY KEY ("goalId")
);

-- CreateTable
CREATE TABLE "MealPlan" (
    "mealId" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "breakfast" VARCHAR(255) NOT NULL,
    "lunch" VARCHAR(255) NOT NULL,
    "dinner" VARCHAR(255) NOT NULL,

    CONSTRAINT "MealPlan_pkey" PRIMARY KEY ("mealId")
);

-- CreateTable
CREATE TABLE "FoodItem" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "calory" INTEGER,
    "carbs" INTEGER,
    "fat" INTEGER,
    "protein" INTEGER,
    "state" INTEGER,
    "foodImage" BYTEA,

    CONSTRAINT "FoodItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FoodPreference" (
    "preferenceId" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "foodId" INTEGER NOT NULL,
    "liked" INTEGER,

    CONSTRAINT "FoodPreference_pkey" PRIMARY KEY ("preferenceId")
);

-- CreateIndex
CREATE UNIQUE INDEX "GeneralUser_id_key" ON "GeneralUser"("id");

-- CreateIndex
CREATE UNIQUE INDEX "Account_accountId_key" ON "Account"("accountId");

-- CreateIndex
CREATE UNIQUE INDEX "Account_accountNo_key" ON "Account"("accountNo");

-- CreateIndex
CREATE UNIQUE INDEX "Account_username_key" ON "Account"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Account_email_key" ON "Account"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Moderator_moderatorId_key" ON "Moderator"("moderatorId");

-- CreateIndex
CREATE UNIQUE INDEX "UserGoal_goalId_key" ON "UserGoal"("goalId");

-- CreateIndex
CREATE UNIQUE INDEX "UserGoal_accountNo_key" ON "UserGoal"("accountNo");

-- CreateIndex
CREATE UNIQUE INDEX "MealPlan_mealId_key" ON "MealPlan"("mealId");

-- CreateIndex
CREATE UNIQUE INDEX "MealPlan_userId_key" ON "MealPlan"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "FoodItem_id_key" ON "FoodItem"("id");

-- CreateIndex
CREATE UNIQUE INDEX "FoodPreference_preferenceId_key" ON "FoodPreference"("preferenceId");

-- CreateIndex
CREATE UNIQUE INDEX "FoodPreference_userId_key" ON "FoodPreference"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "FoodPreference_foodId_key" ON "FoodPreference"("foodId");

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_accountNo_fkey" FOREIGN KEY ("accountNo") REFERENCES "GeneralUser"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserGoal" ADD CONSTRAINT "UserGoal_accountNo_fkey" FOREIGN KEY ("accountNo") REFERENCES "GeneralUser"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MealPlan" ADD CONSTRAINT "MealPlan_userId_fkey" FOREIGN KEY ("userId") REFERENCES "GeneralUser"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FoodPreference" ADD CONSTRAINT "FoodPreference_userId_fkey" FOREIGN KEY ("userId") REFERENCES "GeneralUser"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "FoodPreference" ADD CONSTRAINT "FoodPreference_foodId_fkey" FOREIGN KEY ("foodId") REFERENCES "FoodItem"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
