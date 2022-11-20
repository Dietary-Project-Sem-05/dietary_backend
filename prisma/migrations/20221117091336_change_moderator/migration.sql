/*
  Warnings:

  - You are about to alter the column `telephoneNo` on the `Moderator` table. The data in that column could be lost. The data in that column will be cast from `VarChar(255)` to `VarChar(10)`.
  - A unique constraint covering the columns `[email]` on the table `Moderator` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[username]` on the table `Moderator` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `email` to the `Moderator` table without a default value. This is not possible if the table is not empty.
  - Added the required column `firstName` to the `Moderator` table without a default value. This is not possible if the table is not empty.
  - Added the required column `lastName` to the `Moderator` table without a default value. This is not possible if the table is not empty.
  - Added the required column `password` to the `Moderator` table without a default value. This is not possible if the table is not empty.
  - Added the required column `username` to the `Moderator` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Moderator" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "email" VARCHAR(255) NOT NULL,
ADD COLUMN     "firstName" VARCHAR(255) NOT NULL,
ADD COLUMN     "isFirstTime" BOOLEAN NOT NULL DEFAULT true,
ADD COLUMN     "lastName" VARCHAR(255) NOT NULL,
ADD COLUMN     "password" VARCHAR(255) NOT NULL,
ADD COLUMN     "username" TEXT NOT NULL,
ALTER COLUMN "telephoneNo" SET DATA TYPE VARCHAR(10);

-- CreateIndex
CREATE UNIQUE INDEX "Moderator_email_key" ON "Moderator"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Moderator_username_key" ON "Moderator"("username");
