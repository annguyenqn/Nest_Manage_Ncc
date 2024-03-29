-- CreateEnum
CREATE TYPE "RoleType" AS ENUM ('Admin', 'CompanyOwner', 'Agent', 'Tenant', 'Owner');

-- CreateEnum
CREATE TYPE "StatusType" AS ENUM ('Active', 'Inactive', 'Deleted');

-- CreateEnum
CREATE TYPE "OnboardStatus" AS ENUM ('Pending', 'InProgress', 'Completed', 'Failed');

-- CreateTable
CREATE TABLE "User" (
    "UserID" SERIAL NOT NULL,
    "Email" TEXT NOT NULL,
    "Password" TEXT NOT NULL,
    "FirstName" TEXT NOT NULL,
    "LastName" TEXT NOT NULL,
    "Role" "RoleType" NOT NULL,
    "Status" "StatusType" NOT NULL,
    "OnboardTime" TIMESTAMP(3) NOT NULL,
    "LastLogin" TIMESTAMP(3),

    CONSTRAINT "User_pkey" PRIMARY KEY ("UserID")
);

-- CreateTable
CREATE TABLE "Company" (
    "CompanyID" SERIAL NOT NULL,
    "CompanyName" TEXT NOT NULL,
    "OnboardTime" TIMESTAMP(3) NOT NULL,
    "ArchiveTime" TIMESTAMP(3),
    "CompanyMailbox" TEXT,
    "NumberOfProperties" INTEGER NOT NULL,
    "NumberOfAgents" INTEGER NOT NULL,

    CONSTRAINT "Company_pkey" PRIMARY KEY ("CompanyID")
);

-- CreateTable
CREATE TABLE "Agent" (
    "AgentID" SERIAL NOT NULL,
    "UserId" INTEGER NOT NULL,
    "CompanyID" INTEGER NOT NULL,
    "Status" "StatusType" NOT NULL,
    "InviteTime" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Agent_pkey" PRIMARY KEY ("AgentID")
);

-- CreateTable
CREATE TABLE "Property" (
    "PropertyID" SERIAL NOT NULL,
    "UserId" INTEGER NOT NULL,
    "StreetLine" TEXT NOT NULL,
    "Status" TEXT NOT NULL,
    "Type" TEXT NOT NULL,
    "AssignedAgentID" INTEGER NOT NULL,

    CONSTRAINT "Property_pkey" PRIMARY KEY ("PropertyID")
);

-- CreateTable
CREATE TABLE "Unit" (
    "UnitID" SERIAL NOT NULL,
    "PropertyID" INTEGER NOT NULL,
    "StreetLine" TEXT NOT NULL,
    "AssignedAgentID" INTEGER NOT NULL,

    CONSTRAINT "Unit_pkey" PRIMARY KEY ("UnitID")
);

-- CreateTable
CREATE TABLE "InvitedAgent" (
    "InvitedAgentID" SERIAL NOT NULL,
    "CompanyID" INTEGER NOT NULL,
    "FirstName" TEXT NOT NULL,
    "LastName" TEXT NOT NULL,
    "Email" TEXT NOT NULL,
    "Type" "RoleType" NOT NULL,
    "InviteTime" TIMESTAMP(3) NOT NULL,
    "Status" "StatusType" NOT NULL,

    CONSTRAINT "InvitedAgent_pkey" PRIMARY KEY ("InvitedAgentID")
);

-- CreateTable
CREATE TABLE "AgentOnboardTracking" (
    "TrackingID" SERIAL NOT NULL,
    "AgentID" INTEGER NOT NULL,
    "Status" "OnboardStatus" NOT NULL,
    "InviteTime" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AgentOnboardTracking_pkey" PRIMARY KEY ("TrackingID")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_Email_key" ON "User"("Email");

-- AddForeignKey
ALTER TABLE "Agent" ADD CONSTRAINT "Agent_UserId_fkey" FOREIGN KEY ("UserId") REFERENCES "User"("UserID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Agent" ADD CONSTRAINT "Agent_CompanyID_fkey" FOREIGN KEY ("CompanyID") REFERENCES "Company"("CompanyID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property" ADD CONSTRAINT "Property_UserId_fkey" FOREIGN KEY ("UserId") REFERENCES "User"("UserID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Property" ADD CONSTRAINT "Property_AssignedAgentID_fkey" FOREIGN KEY ("AssignedAgentID") REFERENCES "Agent"("AgentID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Unit" ADD CONSTRAINT "Unit_PropertyID_fkey" FOREIGN KEY ("PropertyID") REFERENCES "Property"("PropertyID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Unit" ADD CONSTRAINT "Unit_AssignedAgentID_fkey" FOREIGN KEY ("AssignedAgentID") REFERENCES "Agent"("AgentID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InvitedAgent" ADD CONSTRAINT "InvitedAgent_CompanyID_fkey" FOREIGN KEY ("CompanyID") REFERENCES "Company"("CompanyID") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AgentOnboardTracking" ADD CONSTRAINT "AgentOnboardTracking_AgentID_fkey" FOREIGN KEY ("AgentID") REFERENCES "Agent"("AgentID") ON DELETE RESTRICT ON UPDATE CASCADE;
