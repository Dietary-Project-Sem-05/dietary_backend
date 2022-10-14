-- CreateEnum
CREATE TYPE "Role" AS ENUM ('USER', 'ADMIN', 'MODERATOR');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE', 'OTHER');

-- CreateTable
CREATE TABLE "GeneralUser" (
    "userId" SERIAL NOT NULL,
    "dateOfBirth" TIMESTAMP(3) NOT NULL,
    "gender" "Gender" NOT NULL,
    "weight" INTEGER NOT NULL,
    "height" INTEGER NOT NULL,
    "activityType" TEXT,
    "exerciseType" TEXT,
    "mealPreferences" TEXT,
    "medicalConditions" TEXT,
    "startingDate" TIMESTAMP(3) NOT NULL,
    "notificaionDay" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "GeneralUser_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "Account" (
    "accountId" SERIAL NOT NULL,
    "activityNo" INTEGER NOT NULL,
    "userType" "Role" NOT NULL DEFAULT 'USER',
    "first_name" TEXT,
    "last_name" TEXT,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,

    CONSTRAINT "Account_pkey" PRIMARY KEY ("accountId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Account_activityNo_key" ON "Account"("activityNo");

-- CreateIndex
CREATE UNIQUE INDEX "Account_username_key" ON "Account"("username");

-- CreateIndex
CREATE UNIQUE INDEX "Account_email_key" ON "Account"("email");

-- AddForeignKey
ALTER TABLE "Account" ADD CONSTRAINT "Account_activityNo_fkey" FOREIGN KEY ("activityNo") REFERENCES "GeneralUser"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;
