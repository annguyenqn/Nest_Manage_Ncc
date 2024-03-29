// const { PrismaClient } = require('@prisma/client');
// const prisma = new PrismaClient();

// async function main() {
//     // Tạo người dùng
//     const user1 = await prisma.user.create({
//         data: {
//             Email: 'user1@example.com',
//             Password: 'password123',
//             FirstName: 'John',
//             LastName: 'Doe',
//             Role: 'Admin',
//             Status: 'Active',
//             OnboardTime: new Date(),
//         },
//     });

//     const user2 = await prisma.user.create({
//         data: {
//             Email: 'user2@example.com',
//             Password: 'password456',
//             FirstName: 'Jane',
//             LastName: 'Smith',
//             Role: 'Agent',
//             Status: 'Inactive',
//             OnboardTime: new Date(),
//         },
//     });

//     // Tạo công ty
//     const company1 = await prisma.company.create({
//         data: {
//             CompanyName: 'Company ABC',
//             OnboardTime: new Date(),
//             NumberOfProperties: 10,
//             NumberOfAgents: 5,
//         },
//     });

//     // Tạo agent
//     const agent1 = await prisma.agent.create({
//         data: {
//             UserID: user2.UserID,
//             CompanyID: company1.CompanyID,
//             Status: 'Active',
//             InviteTime: new Date(),
//         },
//     });

//     // Tạo property
//     const property1 = await prisma.property.create({
//         data: {
//             UserId: user1.UserID,
//             StreetLine: '123 Main St',
//             Status: 'Available',
//             Type: 'House',
//             AssignedAgentID: agent1.AgentID,
//         },
//     });

//     // Tạo unit
//     const unit1 = await prisma.unit.create({
//         data: {
//             PropertyID: property1.PropertyID,
//             StreetLine: 'Apartment 101',
//             AssignedAgentID: agent1.AgentID,
//         },
//     });

//     console.log('Seeder completed!');
// }

// main()
//     .catch((e) => {
//         console.error(e);
//         process.exit(1);
//     })
//     .finally(async () => {
//         await prisma.$disconnect();
//     });
