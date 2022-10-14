/*
  Warnings:

  - The values [USER] on the enum `Role` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `activityNo` on the `Account` table. All the data in the column will be lost.
  - You are about to alter the column `email` on the `Account` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `password` on the `Account` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `firstName` on the `Account` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to alter the column `lastName` on the `Account` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(255)`.
  - You are about to drop the `GeneralUser` table. If the table is not empty, all the data it contains will be lost.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "Role_new" AS ENUM ('ADMIN', 'MODERATOR');
ALTER TABLE "Account" ALTER COLUMN "userType" DROP DEFAULT;
ALTER TABLE "Account" ALTER COLUMN "userType" TYPE "Role_new" USING ("userType"::text::"Role_new");
ALTER TYPE "Role" RENAME TO "Role_old";
ALTER TYPE "Role_new" RENAME TO "Role";
DROP TYPE "Role_old";
ALTER TABLE "Account" ALTER COLUMN "userType" SET DEFAULT 'MODERATOR';
COMMIT;

-- DropForeignKey
ALTER TABLE "Account" DROP CONSTRAINT "Account_activityNo_fkey";

-- DropIndex
DROP INDEX "Account_activityNo_key";

-- AlterTable
ALTER TABLE "Account" DROP COLUMN "activityNo",
ALTER COLUMN "userType" SET DEFAULT 'MODERATOR',
ALTER COLUMN "email" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "password" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "firstName" SET DATA TYPE VARCHAR(255),
ALTER COLUMN "lastName" SET DATA TYPE VARCHAR(255);

-- DropTable
DROP TABLE "GeneralUser";

-- DropEnum
DROP TYPE "Gender";
